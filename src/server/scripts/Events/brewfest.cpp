/*
 * This file is part of the TrinityCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "CreatureAIImpl.h"
#include "Player.h"
#include "SpellAuraEffects.h"
#include "SpellScript.h"
#include "World.h"

enum RamBlaBla
{
    SPELL_GIDDYUP                           = 42924,
    SPELL_RENTAL_RACING_RAM                 = 43883,
    SPELL_SWIFT_WORK_RAM                    = 43880,
    SPELL_RENTAL_RACING_RAM_AURA            = 42146,
    SPELL_RAM_LEVEL_NEUTRAL                 = 43310,
    SPELL_RAM_TROT                          = 42992,
    SPELL_RAM_CANTER                        = 42993,
    SPELL_RAM_GALLOP                        = 42994,
    SPELL_RAM_FATIGUE                       = 43052,
    SPELL_EXHAUSTED_RAM                     = 43332,
    SPELL_RELAY_RACE_TURN_IN                = 44501,

    // Quest
    SPELL_BREWFEST_QUEST_SPEED_BUNNY_GREEN  = 43345,
    SPELL_BREWFEST_QUEST_SPEED_BUNNY_YELLOW = 43346,
    SPELL_BREWFEST_QUEST_SPEED_BUNNY_RED    = 43347
};

// 42924 - Giddyup!
class spell_brewfest_giddyup : public SpellScriptLoader
{
    public:
        spell_brewfest_giddyup() : SpellScriptLoader("spell_brewfest_giddyup") { }

        class spell_brewfest_giddyup_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_brewfest_giddyup_AuraScript);

            void OnChange(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (!target->HasAura(SPELL_RENTAL_RACING_RAM) && !target->HasAura(SPELL_SWIFT_WORK_RAM))
                {
                    target->RemoveAura(GetId());
                    return;
                }

                if (target->HasAura(SPELL_EXHAUSTED_RAM))
                    return;

                switch (GetStackAmount())
                {
                    case 1: // green
                        target->RemoveAura(SPELL_RAM_LEVEL_NEUTRAL);
                        target->RemoveAura(SPELL_RAM_CANTER);
                        target->CastSpell(target, SPELL_RAM_TROT, true);
                        break;
                    case 6: // yellow
                        target->RemoveAura(SPELL_RAM_TROT);
                        target->RemoveAura(SPELL_RAM_GALLOP);
                        target->CastSpell(target, SPELL_RAM_CANTER, true);
                        break;
                    case 11: // red
                        target->RemoveAura(SPELL_RAM_CANTER);
                        target->CastSpell(target, SPELL_RAM_GALLOP, true);
                        break;
                    default:
                        break;
                }

                if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_DEFAULT)
                {
                    target->RemoveAura(SPELL_RAM_TROT);
                    target->CastSpell(target, SPELL_RAM_LEVEL_NEUTRAL, true);
                }
            }

            void OnPeriodic(AuraEffect const* /*aurEff*/)
            {
                GetTarget()->RemoveAuraFromStack(GetId());
            }

            void Register() override
            {
                AfterEffectApply += AuraEffectApplyFn(spell_brewfest_giddyup_AuraScript::OnChange, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                OnEffectRemove += AuraEffectRemoveFn(spell_brewfest_giddyup_AuraScript::OnChange, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_CHANGE_AMOUNT_MASK);
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_brewfest_giddyup_AuraScript::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_brewfest_giddyup_AuraScript();
        }
};

// 43310 - Ram Level - Neutral
// 42992 - Ram - Trot
// 42993 - Ram - Canter
// 42994 - Ram - Gallop
class spell_brewfest_ram : public SpellScriptLoader
{
    public:
        spell_brewfest_ram() : SpellScriptLoader("spell_brewfest_ram") { }

        class spell_brewfest_ram_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_brewfest_ram_AuraScript);

            void OnPeriodic(AuraEffect const* aurEff)
            {
                Unit* target = GetTarget();
                if (target->HasAura(SPELL_EXHAUSTED_RAM))
                    return;

                switch (GetId())
                {
                    case SPELL_RAM_LEVEL_NEUTRAL:
                        if (Aura* aura = target->GetAura(SPELL_RAM_FATIGUE))
                            aura->ModStackAmount(-4);
                        break;
                    case SPELL_RAM_TROT: // green
                        if (Aura* aura = target->GetAura(SPELL_RAM_FATIGUE))
                            aura->ModStackAmount(-2);
                        if (aurEff->GetTickNumber() == 4)
                            target->CastSpell(target, SPELL_BREWFEST_QUEST_SPEED_BUNNY_GREEN, true);
                        break;
                    case SPELL_RAM_CANTER:
                    {
                        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
                        args.AddSpellMod(SPELLVALUE_AURA_STACK, 1);
                        target->CastSpell(target, SPELL_RAM_FATIGUE, args);
                        if (aurEff->GetTickNumber() == 8)
                            target->CastSpell(target, SPELL_BREWFEST_QUEST_SPEED_BUNNY_YELLOW, true);
                        break;
                    }
                    case SPELL_RAM_GALLOP:
                    {
                        CastSpellExtraArgs args(TRIGGERED_FULL_MASK);
                        args.AddSpellMod(SPELLVALUE_AURA_STACK, target->HasAura(SPELL_RAM_FATIGUE) ? 4 : 5 /*Hack*/);
                        target->CastSpell(target, SPELL_RAM_FATIGUE, args);
                        if (aurEff->GetTickNumber() == 8)
                            target->CastSpell(target, SPELL_BREWFEST_QUEST_SPEED_BUNNY_RED, true);
                        break;
                    }
                    default:
                        break;
                }

            }

            void Register() override
            {
                OnEffectPeriodic += AuraEffectPeriodicFn(spell_brewfest_ram_AuraScript::OnPeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_brewfest_ram_AuraScript();
        }
};

// 43052 - Ram Fatigue
class spell_brewfest_ram_fatigue : public SpellScriptLoader
{
    public:
        spell_brewfest_ram_fatigue() : SpellScriptLoader("spell_brewfest_ram_fatigue") { }

        class spell_brewfest_ram_fatigue_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_brewfest_ram_fatigue_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();

                if (GetStackAmount() == 101)
                {
                    target->RemoveAura(SPELL_RAM_LEVEL_NEUTRAL);
                    target->RemoveAura(SPELL_RAM_TROT);
                    target->RemoveAura(SPELL_RAM_CANTER);
                    target->RemoveAura(SPELL_RAM_GALLOP);
                    target->RemoveAura(SPELL_GIDDYUP);

                    target->CastSpell(target, SPELL_EXHAUSTED_RAM, true);
                }
            }

            void Register() override
            {
                AfterEffectApply += AuraEffectApplyFn(spell_brewfest_ram_fatigue_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL_OR_REAPPLY_MASK);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_brewfest_ram_fatigue_AuraScript();
        }
};

// 43450 - Brewfest - apple trap - friendly DND
class spell_brewfest_apple_trap : public SpellScriptLoader
{
    public:
        spell_brewfest_apple_trap() : SpellScriptLoader("spell_brewfest_apple_trap") { }

        class spell_brewfest_apple_trap_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_brewfest_apple_trap_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                GetTarget()->RemoveAura(SPELL_RAM_FATIGUE);
            }

            void Register() override
            {
                OnEffectApply += AuraEffectApplyFn(spell_brewfest_apple_trap_AuraScript::OnApply, EFFECT_0, SPELL_AURA_FORCE_REACTION, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_brewfest_apple_trap_AuraScript();
        }
};

// 43332 - Exhausted Ram
class spell_brewfest_exhausted_ram : public SpellScriptLoader
{
    public:
        spell_brewfest_exhausted_ram() : SpellScriptLoader("spell_brewfest_exhausted_ram") { }

        class spell_brewfest_exhausted_ram_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_brewfest_exhausted_ram_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                target->CastSpell(target, SPELL_RAM_LEVEL_NEUTRAL, true);
            }

            void Register() override
            {
                OnEffectRemove += AuraEffectApplyFn(spell_brewfest_exhausted_ram_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_MOD_DECREASE_SPEED, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_brewfest_exhausted_ram_AuraScript();
        }
};

// 43714 - Brewfest - Relay Race - Intro - Force - Player to throw- DND
class spell_brewfest_relay_race_intro_force_player_to_throw : public SpellScriptLoader
{
    public:
        spell_brewfest_relay_race_intro_force_player_to_throw() : SpellScriptLoader("spell_brewfest_relay_race_intro_force_player_to_throw") { }

        class spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript);

            void HandleForceCast(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                // All this spells trigger a spell that requires reagents; if the
                // triggered spell is cast as "triggered", reagents are not consumed
                GetHitUnit()->CastSpell(nullptr, GetEffectInfo().TriggerSpell, TriggerCastFlags(TRIGGERED_FULL_MASK & ~TRIGGERED_IGNORE_POWER_AND_REAGENT_COST));
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript::HandleForceCast, EFFECT_0, SPELL_EFFECT_FORCE_CAST);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript();
        }
};

// 43755 - Brewfest - Daily - Relay Race - Player - Increase Mount Duration - DND
class spell_brewfest_relay_race_turn_in : public SpellScriptLoader
{
public:
    spell_brewfest_relay_race_turn_in() : SpellScriptLoader("spell_brewfest_relay_race_turn_in") { }

    class spell_brewfest_relay_race_turn_in_SpellScript : public SpellScript
    {
        PrepareSpellScript(spell_brewfest_relay_race_turn_in_SpellScript);

        void HandleDummy(SpellEffIndex effIndex)
        {
            PreventHitDefaultEffect(effIndex);

            if (Aura* aura = GetHitUnit()->GetAura(SPELL_SWIFT_WORK_RAM))
            {
                aura->SetDuration(aura->GetDuration() + 30 * IN_MILLISECONDS);
                GetCaster()->CastSpell(GetHitUnit(), SPELL_RELAY_RACE_TURN_IN, TRIGGERED_FULL_MASK);
            }
        }

        void Register() override
        {
            OnEffectHitTarget += SpellEffectFn(spell_brewfest_relay_race_turn_in_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        }
    };

    SpellScript* GetSpellScript() const override
    {
        return new spell_brewfest_relay_race_turn_in_SpellScript();
    }
};

// 43876 - Dismount Ram
class spell_brewfest_dismount_ram : public SpellScriptLoader
{
    public:
        spell_brewfest_dismount_ram() : SpellScriptLoader("spell_brewfest_dismount_ram") { }

        class spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript);

            void HandleScript(SpellEffIndex /*effIndex*/)
            {
                GetCaster()->RemoveAura(SPELL_RENTAL_RACING_RAM);
            }

            void Register() override
            {
                OnEffectHitTarget += SpellEffectFn(spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const override
        {
            return new spell_brewfest_relay_race_intro_force_player_to_throw_SpellScript();
        }
};

enum RamBlub
{
    // Horde
    QUEST_BARK_FOR_DROHNS_DISTILLERY        = 11407,
    QUEST_BARK_FOR_TCHALIS_VOODOO_BREWERY   = 11408,

    // Alliance
    QUEST_BARK_BARLEYBREW                   = 11293,
    QUEST_BARK_FOR_THUNDERBREWS             = 11294,

    // Bark for Drohn's Distillery!
    SAY_DROHN_DISTILLERY_1                  = 23520,
    SAY_DROHN_DISTILLERY_2                  = 23521,
    SAY_DROHN_DISTILLERY_3                  = 23522,
    SAY_DROHN_DISTILLERY_4                  = 23523,

    // Bark for T'chali's Voodoo Brewery!
    SAY_TCHALIS_VOODOO_1                    = 23524,
    SAY_TCHALIS_VOODOO_2                    = 23525,
    SAY_TCHALIS_VOODOO_3                    = 23526,
    SAY_TCHALIS_VOODOO_4                    = 23527,

    // Bark for the Barleybrews!
    SAY_BARLEYBREW_1                        = 23464,
    SAY_BARLEYBREW_2                        = 23465,
    SAY_BARLEYBREW_3                        = 23466,
    SAY_BARLEYBREW_4                        = 22941,

    // Bark for the Thunderbrews!
    SAY_THUNDERBREWS_1                      = 23467,
    SAY_THUNDERBREWS_2                      = 23468,
    SAY_THUNDERBREWS_3                      = 23469,
    SAY_THUNDERBREWS_4                      = 22942
};

// 43259 Brewfest  - Barker Bunny 1
// 43260 Brewfest  - Barker Bunny 2
// 43261 Brewfest  - Barker Bunny 3
// 43262 Brewfest  - Barker Bunny 4
class spell_brewfest_barker_bunny : public SpellScriptLoader
{
    public:
        spell_brewfest_barker_bunny() : SpellScriptLoader("spell_brewfest_barker_bunny") { }

        class spell_brewfest_barker_bunny_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_brewfest_barker_bunny_AuraScript);

            bool Load() override
            {
                return GetUnitOwner()->GetTypeId() == TYPEID_PLAYER;
            }

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Player* target = GetTarget()->ToPlayer();

                uint32 BroadcastTextId = 0;

                if (target->GetQuestStatus(QUEST_BARK_FOR_DROHNS_DISTILLERY) == QUEST_STATUS_INCOMPLETE ||
                    target->GetQuestStatus(QUEST_BARK_FOR_DROHNS_DISTILLERY) == QUEST_STATUS_COMPLETE)
                    BroadcastTextId = RAND(SAY_DROHN_DISTILLERY_1, SAY_DROHN_DISTILLERY_2, SAY_DROHN_DISTILLERY_3, SAY_DROHN_DISTILLERY_4);

                if (target->GetQuestStatus(QUEST_BARK_FOR_TCHALIS_VOODOO_BREWERY) == QUEST_STATUS_INCOMPLETE ||
                    target->GetQuestStatus(QUEST_BARK_FOR_TCHALIS_VOODOO_BREWERY) == QUEST_STATUS_COMPLETE)
                    BroadcastTextId = RAND(SAY_TCHALIS_VOODOO_1, SAY_TCHALIS_VOODOO_2, SAY_TCHALIS_VOODOO_3, SAY_TCHALIS_VOODOO_4);

                if (target->GetQuestStatus(QUEST_BARK_BARLEYBREW) == QUEST_STATUS_INCOMPLETE ||
                    target->GetQuestStatus(QUEST_BARK_BARLEYBREW) == QUEST_STATUS_COMPLETE)
                    BroadcastTextId = RAND(SAY_BARLEYBREW_1, SAY_BARLEYBREW_2, SAY_BARLEYBREW_3, SAY_BARLEYBREW_4);

                if (target->GetQuestStatus(QUEST_BARK_FOR_THUNDERBREWS) == QUEST_STATUS_INCOMPLETE ||
                    target->GetQuestStatus(QUEST_BARK_FOR_THUNDERBREWS) == QUEST_STATUS_COMPLETE)
                    BroadcastTextId = RAND(SAY_THUNDERBREWS_1, SAY_THUNDERBREWS_2, SAY_THUNDERBREWS_3, SAY_THUNDERBREWS_4);

                if (BroadcastTextId)
                    target->Talk(BroadcastTextId, CHAT_MSG_SAY, sWorld->getFloatConfig(CONFIG_LISTEN_RANGE_SAY), target);
            }

            void Register() override
            {
                OnEffectApply += AuraEffectApplyFn(spell_brewfest_barker_bunny_AuraScript::OnApply, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_brewfest_barker_bunny_AuraScript();
        }
};

enum BrewfestMountTransformation
{
    SPELL_MOUNT_RAM_100                         = 43900,
    SPELL_MOUNT_RAM_60                          = 43899,
    SPELL_MOUNT_KODO_100                        = 49379,
    SPELL_MOUNT_KODO_60                         = 49378,
    SPELL_BREWFEST_MOUNT_TRANSFORM              = 49357,
    SPELL_BREWFEST_MOUNT_TRANSFORM_REVERSE      = 52845,
};

class spell_item_brewfest_mount_transformation : public SpellScript
{
    PrepareSpellScript(spell_item_brewfest_mount_transformation);

    bool Validate(SpellInfo const* /*spell*/) override
    {
        return ValidateSpellInfo(
        {
            SPELL_MOUNT_RAM_100,
            SPELL_MOUNT_RAM_60,
            SPELL_MOUNT_KODO_100,
            SPELL_MOUNT_KODO_60
        });
    }

    void HandleDummy(SpellEffIndex /* effIndex */)
    {
        Player* caster = GetCaster()->ToPlayer();
        if (caster->HasAuraType(SPELL_AURA_MOUNTED))
        {
            caster->RemoveAurasByType(SPELL_AURA_MOUNTED);
            uint32 spell_id;

            switch (GetSpellInfo()->Id)
            {
                case SPELL_BREWFEST_MOUNT_TRANSFORM:
                    if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
                        spell_id = caster->GetTeam() == ALLIANCE ? SPELL_MOUNT_RAM_100 : SPELL_MOUNT_KODO_100;
                    else
                        spell_id = caster->GetTeam() == ALLIANCE ? SPELL_MOUNT_RAM_60 : SPELL_MOUNT_KODO_60;
                    break;
                case SPELL_BREWFEST_MOUNT_TRANSFORM_REVERSE:
                    if (caster->GetSpeedRate(MOVE_RUN) >= 2.0f)
                        spell_id = caster->GetTeam() == HORDE ? SPELL_MOUNT_RAM_100 : SPELL_MOUNT_KODO_100;
                    else
                        spell_id = caster->GetTeam() == HORDE ? SPELL_MOUNT_RAM_60 : SPELL_MOUNT_KODO_60;
                    break;
                default:
                    return;
            }
            caster->CastSpell(caster, spell_id, true);
        }
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_brewfest_mount_transformation::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

void AddSC_event_brewfest()
{
    new spell_brewfest_giddyup();
    new spell_brewfest_ram();
    new spell_brewfest_ram_fatigue();
    new spell_brewfest_apple_trap();
    new spell_brewfest_exhausted_ram();
    new spell_brewfest_relay_race_intro_force_player_to_throw();
    new spell_brewfest_relay_race_turn_in();
    new spell_brewfest_dismount_ram();
    new spell_brewfest_barker_bunny();
    RegisterSpellScript(spell_item_brewfest_mount_transformation);
}
