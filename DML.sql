--Persona
INSERT INTO persona VALUES ('TVLPTR67L59A856P', 'Patrich', 'Tivoli', 13/06/1999);
INSERT INTO persona VALUES ('XBSBVZ69M12H785L', 'Matteo', 'Montinaro', 10/06/1999);
INSERT INTO persona VALUES ('HTNTCU65S54G532R', 'Francesco', 'Ferramosca', 10/06/1999);
INSERT INTO persona VALUES ('GVDLRG40R55L093B', 'Dario', 'Lampa', 23/04/2000);
INSERT INTO persona VALUES ('SPLGDT91B51D385R', 'Rosa', 'Monte', 12/03/2000);
INSERT INTO persona VALUES ('PBFNDV66D46A202L', 'Bianca', 'Neve', 30/05/2000);
INSERT into persona VALUES ('DWAZZL90P66E868A', 'Matteo', 'Russo', 21/12/1998);
INSERT into persona VALUES ('ZBWRGN88R31F826O', 'Davide', 'Lanza', 12/06/1999);
INSERT INTO persona VALUES ('QSPPTL31H46A087H', 'Maria Assunta', 'Salonti', 10/12/1996);
INSERT INTO persona VALUES ('NFQXHC75S14F130W', 'Fabrizio', 'Perazzo', 23/05/1998);
INSERT into persona VALUES ('LTFDCT70T49E748U', 'Lorenzo', 'Appetito', 19/09/1999);
INSERT into persona VALUES ('BHNYNM85R56F883S', 'Andrea', 'Bacca', 28/07/2997);

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
INSERT INTO personale VALUES ('francesco.ferra99@gmail.com', 'frafryx05', 'HTNTCU65S54G532R', 'PM', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');
INSERT INTO personale VALUES ('matteo.dormo@gmail.com', 'sonic98', 'DWAZZL90P66E868A', 'PD', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');
INSERT INTO personale VALUES ('davide.saxoph@gmail.com', 'saxofono', 'ZBWRGN88R31F826O', 'DO', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');
INSERT INTO personale VALUES ('patrich.tivolotty@gmail.com', 'alanwalker', 'TVLPTR67L59A856P', 'PM', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P');
INSERT INTO personale VALUES ('maria.sal@gmail.com', 'doom', 'QSPPTL31H46A087H', 'PD', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P');
INSERT INTO personale VALUES ('fabri.peroloo@gmail.com', 'persona5', 'NFQXHC75S14F130W', 'DO', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P');
INSERT INTO personale VALUES ('matteyo.montinaro23@gmail.com', 'lovemunchy', 'XBSBVZ69M12H785L', 'PM', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L');
INSERT INTO personale VALUES ('lore.appe@gmail.com', 'lovelega', 'LTFDCT70T49E748U', 'PD', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L');
INSERT INTO personale VALUES ('andrea.blasf@gimail.com', 'germano1', 'BHNYNM85R56F883S', 'DO', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L');

--Acquisto
INSERT INTO acquisto VALUES ('2016-06-22 19:10:25-07', 'BHNYNM85R56F883S', 'andrea.blasf@gimail.com', 'PBFNDV66D46A202L', 50,67);



