UPDATE `creature_template` SET `ainame`='SmartAI', `scriptname`='' WHERE `entry` IN(24642, 24911,24742, 24796, 24537, 24713, 24910, 24790, 23967, 24992);
DELETE FROM `smart_scripts` WHERE `entryorguid` IN(24642, 24911,24742, 24796, 24537, 24713, 24910, 24790, 24992) AND `source_type`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid` =24914 AND `source_type`=0 AND `id`=1;
UPDATE `smart_scripts` SET `link`=1 WHERE  `entryorguid`=24914 AND `source_type`=0 AND `id`=0;
UPDATE `smart_scripts` SET `link`=6 WHERE  `entryorguid`=24786 AND `source_type`=0 AND `id`=5;
DELETE FROM `smart_scripts` WHERE `entryorguid` =24786 AND `source_type`=0 AND `id`=6;
DELETE FROM `smart_scripts` WHERE `entryorguid` =23967 AND `source_type`=0 AND `id`>0;
DELETE FROM `smart_scripts` WHERE `entryorguid` =2474200 AND `source_type`=9;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(24992, 0, 0, 0, 38, 0, 100, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'The Big Gun - On Data set  - Say'),
(24642, 0, 0, 0, 1, 0, 50, 0, 0, 45000, 90000, 180000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Drunken Northsea Pirate - OOC  - Say'),
(24911, 0, 0, 0, 1, 0, 50, 0, 0, 45000, 90000, 180000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Cursed Sea Dog - OOC  - Say'),
(24911, 0, 1, 0, 9, 0, 100, 0, 20, 150, 1000, 3000, 11, 44961, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cursed Sea Dog - On Range (20-150 Yards)  - Cast Shoot'),
(24914, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, 142813, 24992, 0, 0, 0, 0, 0, 'Sorlof - On Just Died  - Set Data (The Big Gun)'),
(24742, 0, 0, 0, 0, 0, 100, 0, 0, 15000, 15000, 30000, 11, 50188, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - IC - Cast Wildly Flailing'),
(24742, 0, 1, 0, 40, 0, 100, 0, 1, 24742, 0, 0, 97, 20, 20, 0, 0, 0, 0, 1, 0, 0, 0, -73.7997, -3435.55, -15.2043, 0, '"Mad" Jonah Sterling - On Reached WP1 - Jump to Hozzer'),
(24742, 0, 2, 0, 2, 0, 100, 1, 0, 25, 0, 0, 80, 2474200, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - On 25% Hp - Run Script'),
(2474200, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 102, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Set HP Regen off'),
(2474200, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Evade'),
(2474200, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Say Line 1'),
(2474200, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 53, 1, 24742, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Start WP'),
(2474200, 9, 4, 0, 0, 0, 100, 0, 7000, 7000, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Say Line 2'),
(2474200, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 85, 44458, 1, 0, 0, 0, 0, 19, 24547, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Invoker Cast Hozzer Feeds'),
(2474200, 9, 6, 0, 0, 0, 100, 0, 3000, 3000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 24547, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Say Line 1 - Hozzer'),
(2474200, 9, 7, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Mad" Jonah Sterling - Script - Despawn'),
(24796, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Spectral Sailor - On Agro - Say'),
(24537, 0, 0, 0, 1, 0, 100, 0, 0, 45000, 90000, 210000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Handsome Terry - OOC  - Say'),
(24713, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - On Agro - Say'),
(24713, 0, 1, 0, 9, 0, 100, 0, 0, 5, 5000, 8000, 11, 50311, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, '"Crowleg" Dan - On Range - Cast Thrash Kick'),
(24910, 0, 0, 0, 1, 0, 100, 0, 0, 45000, 90000, 180000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Captain Ellis - OOC  - Say'),
(24790, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Black Conrad''s Ghost - On Agro  - Say'),
(24790, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Black Conrad''s Ghost - On Death  - Say'),
(24790, 0, 2, 0, 4, 0, 100, 0, 0, 0, 0, 0, 11, 51211, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Black Conrad''s Ghost - On Agro  - Cast Blade Flurry'),
(24790, 0, 3, 0, 9, 0, 100, 0, 0, 5, 10000, 15000, 11, 31022, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Black Conrad''s Ghost - On Range (5 Yrds)  - Cast Ghostly Strike'),
(24786, 0, 6, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 24797, 0, 0, 0, 0, 0, 0, 'Reef Bull - Link - Say (Reef Cow)'),
(23967, 0, 1, 0, 1, 0, 50, 0, 0, 45000, 90000, 180000, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Deranged Explorer - OOC  - Say'),
(23967, 0, 2, 0, 9, 0, 100, 0, 0, 5, 14000, 19000, 11, 11971, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deranged Explorer - On Range (5 Yrds) - Cast Sunder Armor'),
(23967, 0, 3, 0, 9, 0, 100, 0, 0, 5, 3000, 5000, 11, 35857, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Deranged Explorer - On Range (5 Yrds) - Cast Torch');

DELETE FROM `creature_text` WHERE `entry` IN(24642,24911,24992,24742,24547, 24796, 25537, 24910, 24790, 24797, 23967, 24537, 24713);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES
(24642, 0, 0, 'Nothin'' finer than enjoying a fine beverage and the company of some fine buckos... hic!', 12, 0, 100, 1, 0, 0, 'Drunken Northsea Pirate', 23657),
(24642, 0, 1, '...that scurvy dog had two peg legs, a hook for a left hand, two glass eyes and a wooden nose!', 12, 0, 100, 153, 0, 0, 'Drunken Northsea Pirate', 23660),
(24642, 0, 2, 'Nothin'' finer than enjoying a fine beverage and the company of some fine buckos... hic!', 12, 0, 100, 153, 0, 0, 'Drunken Northsea Pirate', 23657),
(24642, 0, 3, 'Whatcha lookin'' at, ye bilge rat?  Har, har.... just kiddin'' with ye, mate!', 12, 0, 100, 6, 0, 0, 'Drunken Northsea Pirate', 23656),
(24642, 0, 4, 'Nothin'' finer than enjoying a fine beverage and the company of some fine buckos... hic!', 12, 0, 100, 22, 0, 0, 'Drunken Northsea Pirate', 23657),
(24642, 0, 5, '...that scurvy dog had two peg legs, a hook for a left hand, two glass eyes and a wooden nose!', 12, 0, 100, 22, 0, 0, 'Drunken Northsea Pirate', 23660),
(24642, 0, 6, 'I ''eard Terry fenced one of ''em pictures for a thousand gold.  Maybe I can get in some of that artwork dealin'' too!', 12, 0, 100, 22, 0, 0, 'Drunken Northsea Pirate', 23671),
(24642, 0, 7, 'I ''eard Terry fenced one of ''em pictures for a thousand gold.  Maybe I can get in some of that artwork dealin'' too!', 12, 0, 100, 6, 0, 0, 'Drunken Northsea Pirate', 23671),
(24642, 0, 8, 'Kiss the gunner''s daughter?  Why I haven''t ever met the lass...', 12, 0, 100, 153, 0, 0, 'Drunken Northsea Pirate', 23670),
(24642, 0, 9, 'Whatcha lookin'' at, ye bilge rat?  Har, har.... just kiddin'' with ye, mate!', 12, 0, 100, 153, 0, 0, 'Drunken Northsea Pirate', 23656),
(24642, 0, 10, 'Grab a seat and ''ave a drink, mate!  Grab me one while yer at it!', 12, 0, 100, 6, 0, 0, 'Drunken Northsea Pirate', 23659),
(24642, 0, 11, 'Grab a seat and ''ave a drink, mate!  Grab me one while yer at it!', 12, 0, 100, 153, 0, 0, 'Drunken Northsea Pirate', 23659),
(24642, 0, 12, 'Nothin'' finer than enjoying a fine beverage and the company of some fine buckos... hic!', 12, 0, 100, 6, 0, 0, 'Drunken Northsea Pirate', 23657),
(24642, 0, 13, '...that scurvy dog had two peg legs, a hook for a left hand, two glass eyes and a wooden nose!', 12, 0, 100, 6, 0, 0, 'Drunken Northsea Pirate', 23660),
(24642, 0, 14, 'Kiss the gunner''s daughter?  Why I haven''t ever met the lass...', 12, 0, 100, 6, 0, 0, 'Drunken Northsea Pirate', 23670),
(24642, 0, 15, 'Whatcha lookin'' at, ye bilge rat?  Har, har.... just kiddin'' with ye, mate!', 12, 0, 100, 22, 0, 0, 'Drunken Northsea Pirate', 23656),
(24642, 0, 16, '"Yaaaaaaaaaarrr... it''s driving me insane!"  Wait... that''s not quite how it goes...', 12, 0, 100, 22, 0, 0, 'Drunken Northsea Pirate', 23658),
(24642, 0, 17, 'I ''eard Terry fenced one of ''em pictures for a thousand gold.  Maybe I can get in some of that artwork dealin'' too!', 12, 0, 100, 153, 0, 0, 'Drunken Northsea Pirate', 23671),
(24642, 0, 18, 'I ''eard Terry fenced one of ''em pictures for a thousand gold.  Maybe I can get in some of that artwork dealin'' too!', 12, 0, 100, 1, 0, 0, 'Drunken Northsea Pirate', 23671),
(24642, 0, 19, '...so he says "Of course I''m not seeing double!  I''ve only got one eye!"', 12, 0, 100, 6, 0, 0, 'Drunken Northsea Pirate', 23665),
(24642, 0, 20, 'Grab a seat and ''ave a drink, mate!  Grab me one while yer at it!', 12, 0, 100, 22, 0, 0, 'Drunken Northsea Pirate', 23659),
(24642, 0, 21, '...so he says "Of course I''m not seeing double!  I''ve only got one eye!"', 12, 0, 100, 1, 0, 0, 'Drunken Northsea Pirate', 23665),
(24642, 0, 22, '"Yaaaaaaaaaarrr... it''s driving me insane!"  Wait... that''s not quite how it goes...', 12, 0, 100, 1, 0, 0, 'Drunken Northsea Pirate', 23658),
(24642, 0, 23, '"Yaaaaaaaaaarrr... it''s driving me insane!"  Wait... that''s not quite how it goes...', 12, 0, 100, 22, 0, 0, 'Drunken Northsea Pirate', 23658),
(24911, 0, 0, 'Take that, landlubber!', 14, 0, 100, 4, 0, 0, 'Cursed Sea Dog', 24047),
(24911, 0, 1, 'Yo-ho-ho, and a bottle of gnomish spirits!', 14, 0, 100, 4, 0, 0, 'Cursed Sea Dog', 24044),
(24911, 0, 2, 'The booty be ours!', 14, 0, 100, 4, 0, 0, 'Cursed Sea Dog', 24048),
(24911, 0, 3, 'Rum and wenches for all!', 14, 0, 100, 4, 0, 0, 'Cursed Sea Dog', 24046),
(24911, 0, 4, 'Take that, landlubber!', 14, 0, 100, 92, 0, 0, 'Cursed Sea Dog', 24047),
(24911, 0, 5, 'Rum and wenches for all!', 14, 0, 100, 92, 0, 0, 'Cursed Sea Dog', 24046),
(24911, 0, 6, 'Yo-ho-ho, and a bottle of gnomish spirits!', 14, 0, 100, 92, 0, 0, 'Cursed Sea Dog', 24044),
(24911, 0, 7, 'The booty be ours!', 14, 0, 100, 92, 0, 0, 'Cursed Sea Dog', 24048),
(24911, 0, 8, 'Thar she blows!', 14, 0, 100, 4, 0, 0, 'Cursed Sea Dog', 24045),
(24992, 0, 0, 'Sorlof''s booty falls to the floor.', 41, 0, 100, 0, 0, 0, 'The Big Gun', 24032),
(24742, 0, 0, 'Yarrrrrrr!  Ye''ll never get me spyglass, bilgesucker!', 14, 0, 100, 0, 0, 3403, '"Mad" Jonah Sterling', 23705),
(24742, 1, 0, 'Is this how you repay your master, you fleabag?  Arrrrrgghh!!', 14, 0, 100, 0, 0, 0, '"Mad" Jonah Sterling to Hozzer', 23851),
(24742, 1, 1, 'Is this how you repay your master, you fleabag?  Arrrrrgghh!!', 14, 0, 100, 0, 0, 3403, '"Mad" Jonah Sterling to Hozzer', 23851),
(24742, 0, 1, 'Yarrrrrrr!  Ye''ll never get me spyglass, bilgesucker!', 14, 0, 100, 0, 0, 0, '"Mad" Jonah Sterling', 23705),
(24796, 0, 0, 'Yer dead, landlubber!', 12, 0, 100, 0, 0, 0, 'Spectral Sailor', 23843),
(24537, 0, 0, 'I don''t know much about art... but I know what I like!', 12, 0, 100, 6, 0, 0, 'Handsome Terry', 23578),
(24547, 0, 0, '%s devours his master''s body.', 16, 0, 100, 0, 0, 0, 'Hozzer', 23854),
(24547, 0, 1, '%s devours his master''s body.', 16, 0, 100, 0, 0, 3403, 'Hozzer', 23854),
(24713, 0, 0, 'Curse that frog!  Yes, I joined the Southsea crew - you want to make something of it, mate?  I''ll cut you down here and now!', 12, 0, 100, 0, 0, 0, '"Crowleg" Dan', 23690),
(24910, 0, 0, 'It may''ave won in life, but it won''t be winnin'' in the afterlife! FIRE!', 14, 0, 100, 0, 0, 0, 'Captain Ellis', 24029),
(24910, 0, 1, 'Fire! Fire for the booty, me hearties!', 14, 0, 100, 0, 0, 0, 'Captain Ellis', 24028),
(24910, 0, 2, 'Fire! Fire, ya yella sea dogs!', 14, 0, 100, 0, 0, 0, 'Captain Ellis', 23997),
(24790, 0, 0, 'Yarrrr!  If it''s me treasure yer lookin'' for... yer gonna have to fight for it!', 12, 0, 100, 1, 0, 0, 'Black Conrad''s Ghost', 23833),
(24790, 1, 1, 'Yarrrrr... dead again!', 12, 0, 100, 0, 0, 0, 'Black Conrad''s Ghost', 23848),
(24797, 0, 0, 'The reef cow and her new bull find true love.', 16, 0, 100, 0, 0, 0, 'Reef Cow to Attracted Reef Bull', 23859),
(23967, 0, 0, 'It''ll all be over soon. Soon you will be in the embrace of That Which Must Not Be Named!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22505),
(23967, 0, 1, 'If you''re here, then IT might be close behind!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22508),
(23967, 0, 2, 'The truth shall set you free. Like us, you will be with IT forever!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22504),
(23967, 0, 3, 'You cannot leave... IT mustn''t find us!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22507),
(23967, 0, 4, 'It''ll all be over soon. Soon you will be in the embrace of That Which Must Not Be Named!', 12, 7, 100, 16, 0, 0, 'Deranged Explorer', 22505),
(23967, 0, 5, 'Now you''ll have to join us... permanently!', 12, 7, 100, 16, 0, 0, 'Deranged Explorer', 22510),
(23967, 0, 6, 'Now you''ll have to join us... permanently!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22510),
(23967, 0, 7, 'Ahahaha! I must find the secrets!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22495),
(23967, 0, 8, 'Forgive me oh great one. I did not mean to learn the truth!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22502),
(23967, 0, 9, 'If only there were more time!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22501),
(23967, 0, 10, 'IT''s coming! HIDE!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22500),
(23967, 0, 11, 'The end is nigh! That Which Must Not Be Named is almost free!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22505),
(23967, 0, 12, 'We''re safe; IT will never reach us here!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22498),
(23967, 0, 13, 'When one studies and digs, one reveals the truth.', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22497),
(23967, 0, 14, 'I will put an end to your life before you realize the horrible truth!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22509),
(23967, 0, 15, 'Intruder! You were sent to destroy us!', 12, 7, 100, 0, 0, 0, 'Deranged Explorer', 22506);

DELETE FROM `waypoints` WHERE `entry`=24742;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`) VALUES 
(24742, 1, -36.128922, -3425.641602, 4.998625, '"Mad" Jonah Sterling'); -- Single WP to trigger jump to Hozzer

