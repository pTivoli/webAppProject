--Persona
INSERT INTO persona VALUES ('TVLPTR67L59A856P', 'Patrich', 'Tivoli', 13/06/1999);
INSERT INTO persona VALUES ('XBSBVZ69M12H785L', 'Matteo', 'Montinaro', 10/06/1999);
INSERT INTO persona VALUES ('HTNTCU65S54G532R', 'Francesco', 'Ferramosca', 10/06/1999);
INSERT INTO persona VALUES ('GVDLRG40R55L093B', 'Dario', 'Lampa', 23/04/2000);
INSERT INTO persona VALUES ('SPLGDT91B51D385R', 'Rosa', 'Monte', 12/03/2000);
INSERT INTO persona VALUES ('PBFNDV66D46A202L', 'Bianca', 'Neve', 30/05/2000);
INSERT into persona VALUES ('DWAZZL90P66E868A', 'Matteo', 'Russo', 21/12/1998);
INSERT into persona VALUES ('ZBWRGN88R31F826O', 'Davide', 'Lanza', 12/06/1999);

--Medico
INSERT INTO medico VALUES ('02ssdd', 'TVLPTR67L59A856P');
INSERT INTO medico VALUES ('10shs', 'XBSBVZ69M12H785L');
INSERT INTO medico VALUES ('69ngde', 'HTNTCU65S54G532R');

--Ricetta
INSERT INTO ricetta VALUES ('AAABBCDDDDDDDEE', 31/01/2020, 'GVDLRG40R55L093B', '02ssdd', 'TVLPTR67L59A856P');
INSERT INTO ricette VALUES ('ASSNNUBBBBBBPLL', 23/02/2020, 'SPLGDT91B51D385R', '10shs', 'XBSBVZ69M12H785L');
INSERT INTO ricette VALUES ('UUUTTFGLLLLLLHJJ',04/03/2020, 'PBFNDV66D46A202L', '69ngde', 'HTNTCU65S54G532R');

--Ruolo
INSERT INTO ruolo VALUES ('REG'); --la regione
INSERT INTO ruolo VALUES ('PM'); --pharmacist manager
INSERT INTO ruolo VALUES ('PD'); --pharmacist doctor
INSERT INTO ruolo VALUES ('DO'); --desktop operator

--Farmacia
INSERT INTO farmacia VALUES ('Pharmaon', 'Via Fiume 1', '03215566767', 'TVLPTR67L59A856P', 'patrich.tivolotty@gmail.com');
INSERT INTO farmacia VALUES ('Ciafarm', 'Via Garibaldi 23', '03334567897', 'XBSBVZ69M12H785L', 'matteyo.montinaro23@gmail.com');
INSERT INTO farmacia VALUES ('Farmahappy', 'Via Garda 32', '03245676324', 'HTNTCU65S54G532R', 'francesco.ferra99@gmail.com');

--Personale
INSERT INTO personale VALUES ('francesco.ferra99@gmail.com', 'frafryx', 'HTNTCU65S54G532R', 'PM', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');
INSERT INTO personale VALUES ('matteo.dormo@gmail.com', 'sonic98', 'DWAZZL90P66E868A', 'DO', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');

INSERT INTO personale VALUES ('patrich.tivolotty@gmail.com', 'immuni', 'TVLPTR67L59A856P', 'PM', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P')


