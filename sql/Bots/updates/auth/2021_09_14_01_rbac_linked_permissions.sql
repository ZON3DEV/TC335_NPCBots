--
SET @PERMISSION_START = 70001;
SET @PERMISSION_END   = 70033;

DELETE FROM `rbac_linked_permissions` WHERE linkedId BETWEEN @PERMISSION_START AND @PERMISSION_END;
INSERT INTO `rbac_linked_permissions` (`id`,`linkedId`) VALUES
('199','70001'),
('197','70002'),
('197','70003'),
('197','70004'),
('197','70005'),
('197','70006'),
('197','70007'),
('197','70008'),
('197','70009'),
('199','70010'),
('199','70011'),
('199','70012'),
('199','70013'),
('199','70014'),
('197','70015'),
('197','70016'),
('197','70017'),
('197','70018'),
('197','70019'),
('197','70020'),
('197','70021'),
('197','70022'),
('199','70023'),
('199','70024'),
('199','70025'),
('199','70026'),
('199','70027'),
('199','70028'),
('199','70029'),
('199','70030'),
('199','70031'),
('196','70032'),
('196','70033');
