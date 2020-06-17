--Persona
INSERT INTO persona VALUES ('TVLPTR67L59A856P', 'Patrich', 'Tivoli', '13/06/1999');
INSERT INTO persona VALUES ('XBSBVZ69M12H785L', 'Matteo', 'Montinaro', '10/06/1999');
INSERT INTO persona VALUES ('HTNTCU65S54G532R', 'Francesco', 'Ferramosca', '10/06/1999');
INSERT INTO persona VALUES ('GVDLRG40R55L093B', 'Dario', 'Lampa', '23/04/2000');
INSERT INTO persona VALUES ('SPLGDT91B51D385R', 'Rosa', 'Monte', '12/03/2000');
INSERT INTO persona VALUES ('PBFNDV66D46A202L', 'Bianca', 'Neve', '30/05/2000');
INSERT into persona VALUES ('DWAZZL90P66E868A', 'Matteo', 'Russo', '21/12/1998');
INSERT into persona VALUES ('ZBWRGN88R31F826O', 'Davide', 'Lanza', '12/06/1999');
INSERT INTO persona VALUES ('QSPPTL31H46A087H', 'Maria Assunta', 'Salonti', '10/12/1996');
INSERT INTO persona VALUES ('NFQXHC75S14F130W', 'Fabrizio', 'Perazzo', '23/05/1998');
INSERT into persona VALUES ('LTFDCT70T49E748U', 'Lorenzo', 'Appetito', '19/09/1999');
INSERT into persona VALUES ('BHNYNM85R56F883S', 'Andrea', 'Bacca', '28/07/2997');

--Medico
INSERT INTO medico VALUES ('02ssdd', 'TVLPTR67L59A856P');
INSERT INTO medico VALUES ('10shs', 'XBSBVZ69M12H785L');
INSERT INTO medico VALUES ('69ngde', 'HTNTCU65S54G532R');

--Ricetta
INSERT INTO ricetta VALUES ('AAABBCDDDDDDDEE', '31/01/2020', 'GVDLRG40R55L093B', '02ssdd', 'TVLPTR67L59A856P');
INSERT INTO ricetta VALUES ('ASSNNUBBBBBBPLL', '23/02/2020', 'SPLGDT91B51D385R', '10shs', 'XBSBVZ69M12H785L');
INSERT INTO ricetta VALUES ('UUUTTFGLLLLLLHJ','04/03/2020', 'PBFNDV66D46A202L', '69ngde', 'HTNTCU65S54G532R');

--Ruolo
INSERT INTO ruolo VALUES ('REG'); --la regione
INSERT INTO ruolo VALUES ('PM'); --pharmacist manager
INSERT INTO ruolo VALUES ('PD'); --pharmacist doctor
INSERT INTO ruolo VALUES ('DO'); --desktop operator

--Personale
INSERT INTO personale VALUES ('francesco.ferra99@gmail.com', 'frafryx05', 'HTNTCU65S54G532R', 'PM', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');
INSERT INTO personale VALUES ('matteo.strawberry@gmail.com', 'sonic98', 'DWAZZL90P66E868A', 'PD', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');
INSERT INTO personale VALUES ('davide.saxoph@gmail.com', 'saxofono', 'ZBWRGN88R31F826O', 'DO', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');
INSERT INTO personale VALUES ('patrich.tivolotty@gmail.com', 'alanwalker', 'TVLPTR67L59A856P', 'PM', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P');
INSERT INTO personale VALUES ('maria.sal@gmail.com', 'doom', 'QSPPTL31H46A087H', 'PD', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P');
INSERT INTO personale VALUES ('fabri.peroloo@gmail.com', 'persona5', 'NFQXHC75S14F130W', 'DO', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P');
INSERT INTO personale VALUES ('matteyo.montinaro23@gmail.com', 'lovemunchy', 'XBSBVZ69M12H785L', 'PM', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L');
INSERT INTO personale VALUES ('lore.appe@gmail.com', 'lovelega', 'LTFDCT70T49E748U', 'PD', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L');
INSERT INTO personale VALUES ('andrea.blasf@gimail.com', 'germano1', 'BHNYNM85R56F883S', 'DO', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L');

--Farmacia
INSERT INTO farmacia VALUES ('Pharmaon', 'Via Fiume 1', '03215566767', 'TVLPTR67L59A856P', 'patrich.tivolotty@gmail.com');
INSERT INTO farmacia VALUES ('Ciafarm', 'Via Garibaldi 23', '03334567897', 'XBSBVZ69M12H785L', 'matteyo.montinaro23@gmail.com');
INSERT INTO farmacia VALUES ('Farmahappy', 'Via Garda 32', '03245676324', 'HTNTCU65S54G532R', 'francesco.ferra99@gmail.com');

--Acquisto
INSERT INTO acquisto VALUES ('22-02-2019 19:10:25-07', 'BHNYNM85R56F883S', 'andrea.blasf@gimail.com', 'PBFNDV66D46A202L', 50.67);
INSERT INTO acquisto VALUES ('01-03-2016 17:10:25-07', 'DWAZZL90P66E868A', 'matteo.strawberry@gmail.com', 'SPLGDT91B51D385R', 27.00);
INSERT INTO acquisto VALUES ('14-06-2020 12:15:24-07', 'NFQXHC75S14F130W', 'fabri.peroloo@gmail.com', 'GVDLRG40R55L093B', 12.60);

--Magazzino
INSERT INTO magazzino VALUES ('Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P');
INSERT INTO magazzino VALUES ('Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L');
INSERT INTO magazzino VALUES ('Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R');

--Farmaco
INSERT INTO farmaco VALUES ('01AM', 'Amoxicillina', 15.00, True, '12-07-2021');
INSERT INTO farmaco VALUES ('30GM', 'Gentamicina', 9.00, True, '12-08-2021');
INSERT INTO farmaco VALUES ('27MC', 'Macladin', 16.00, True, '30-07-2021');
INSERT INTO farmaco VALUES ('03DE', 'Deltacortene', 13.90 , True, '12-05-2021');
INSERT INTO farmaco VALUES ('04DS', 'Desloratadina', 25.00, True, '28-08-2021');
INSERT INTO farmaco VALUES ('98PA', 'Paracetamolo', 10.00, False, '10-12-2022');
INSERT INTO farmaco VALUES ('08AC', 'Acido Acetilsalicinico', 8.50, False, '13-02-2021');
INSERT INTO farmaco VALUES ('09AS', 'Acido Ascorbico ', 8.50, False, '13-02-2021');

--Magazzino_Farmaco
INSERT INTO Magazzino_Farmaco VALUES ('31', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '01AM');
INSERT INTO Magazzino_Farmaco VALUES ('12', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '30GM');
INSERT INTO Magazzino_Farmaco VALUES ('5', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '27MC');
INSERT INTO Magazzino_Farmaco VALUES ('26', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '03DE');
INSERT INTO Magazzino_Farmaco VALUES ('11', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '04DS');
INSERT INTO Magazzino_Farmaco VALUES ('1', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '98PA');
INSERT INTO Magazzino_Farmaco VALUES ('23', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '08AC');
INSERT INTO Magazzino_Farmaco VALUES ('7', 'Farmahappy', 'Via Garda 32', 'HTNTCU65S54G532R', '09AS');
INSERT INTO Magazzino_Farmaco VALUES ('12', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P', '01AM');
INSERT INTO Magazzino_Farmaco VALUES ('2', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P', '30GM');
INSERT INTO Magazzino_Farmaco VALUES ('1', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P', '27MC');
INSERT INTO Magazzino_Farmaco VALUES ('21', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P', '03DE');
INSERT INTO Magazzino_Farmaco VALUES ('9', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P', '98PA');
INSERT INTO Magazzino_Farmaco VALUES ('21', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P', '08AC');
INSERT INTO Magazzino_Farmaco VALUES ('3', 'Pharmaon', 'Via Fiume 1', 'TVLPTR67L59A856P', '09AS');
INSERT INTO Magazzino_Farmaco VALUES ('3', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L', '01AM');
INSERT INTO Magazzino_Farmaco VALUES ('12', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L', '30GM');
INSERT INTO Magazzino_Farmaco VALUES ('15', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L', '27MC');
INSERT INTO Magazzino_Farmaco VALUES ('2', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L', '03DE');
INSERT INTO Magazzino_Farmaco VALUES ('12', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L', '04DS');
INSERT INTO Magazzino_Farmaco VALUES ('10', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L', '98PA');
INSERT INTO Magazzino_Farmaco VALUES ('5', 'Ciafarm', 'Via Garibaldi 23', 'XBSBVZ69M12H785L', '09AS');

--Acquisto_Farmaco
INSERT INTO Acquisto_Farmaco VALUES (2, '22-02-2019 19:10:25-07', 'BHNYNM85R56F883S', '30GM');
INSERT INTO Acquisto_Farmaco VALUES (1, '22-02-2019 19:10:25-07', 'BHNYNM85R56F883S', '03DE');
INSERT INTO Acquisto_Farmaco VALUES (1, '01-03-2016 17:10:25-07', 'DWAZZL90P66E868A', '01AM');
INSERT INTO Acquisto_Farmaco VALUES (1, '14-06-2020 12:15:24-07', 'NFQXHC75S14F130W', '04DS');