/* faccio  VCS -> update project, dopo lavoro, dopo committo le modifiche VCS-> commit changes, poi pusho: CCS -> git ->pushamolo
*/

create table Persona(
  codiceFiscale char(16) primary key,
  nome varchar(20) not null,
  cognome varchar(20) not null,
  dataNascita date
);

create table Medico(
  codiceRegionale varchar(10),
  medico_CFPersona char(16),
  primary key(codiceRegionale, medico_CFPersona),
  foreign key (medico_CFPersona) references Persona(codiceFiscale) on delete cascade on update cascade
);

create table Ricetta(
  codiceRicetta varchar(10),
  data date,
  codiceFiscale char(11),        --per le persone giuridiche la lunghezza del cf è 16 caratteri
  ricetta_Codice_Medico varchar(10),
  ricetta_Medico_Persona char(16),
  primary key(codiceRicetta, ricetta_Codice_Medico, ricetta_Medico_Persona),
  foreign key (ricetta_Codice_Medico, ricetta_Medico_Persona) references Medico(codiceRegionale, medico_CFPersona) on delete set null on update cascade
);

create table Ruolo(
  nome VARCHAR(30) PRIMARY KEY
);

create table Farmacia(
  nome VARCHAR(30),
  indirizzo VARCHAR(30),
  telefono VARCHAR(15),
  cfTitolare CHAR(16),
  mailTitolare VARCHAR(30),
  PRIMARY KEY (nome, indirizzo, cfTitolare)
);

create table Personale(
  mail varchar(30),
  pwd varchar(20),
  personale_CFPersona char(16),
  ruoloPersonale VARCHAR(30),
  nomeFarmacia VARCHAR(30),
  indirizzoFarmacia VARCHAR(30),
  CF_titolare_farmacia char(16),
  primary key(personale_CFPersona, mail),
  foreign key (personale_CFPersona) references Persona(codiceFiscale),
  FOREIGN KEY (ruoloPersonale) REFERENCES Ruolo(nome) on delete set null on update cascade
);

create table Acquisto(
  timest TIMESTAMP,
  cfPersonale CHAR(16),
  mailPersonale varchar(30),
  cfPersona CHAR(16),
  totale INTEGER,
  PRIMARY KEY (timest, cfPersonale),
  FOREIGN KEY (cfPersona) REFERENCES Persona(codiceFiscale) on delete set null on update cascade,
  FOREIGN KEY (cfPersonale, mailPersonale) REFERENCES  Personale(personale_CFPersona, mail) on delete set null on update cascade
);

create TABLE Magazzino(
  nomeFarmacia VARCHAR(30),
  indirizzoFarmacia VARCHAR(30),
  cfTitolareFarmacia CHAR(16),
  PRIMARY KEY (nomeFarmacia, indirizzoFarmacia, cfTitolareFarmacia) ,
  FOREIGN KEY (nomeFarmacia, indirizzoFarmacia, cfTitolareFarmacia) REFERENCES Farmacia(nome, indirizzo, cfTitolare) on delete cascade on update cascade
);

CREATE TABLE Farmaco(
  Codice varchar(10),
  Nome VARCHAR(20),
  Prezzo decimal(6,2),
  ObbligoRicetta boolean DEFAULT false,
  Scadenza date,
  PRIMARY KEY (Codice)
);

CREATE TABLE Messaggio(
  Timest TIMESTAMP,
  Testo VARCHAR(300),
  personale_Mitt char(16),
  personale_mail_mitt varchar(30),
  PRIMARY KEY (Timest, personale_Mitt, personale_mail_mitt),
  FOREIGN KEY (personale_Mitt, personale_mail_mitt) REFERENCES Personale(personale_CFPersona, mail) on delete cascade on update cascade

);

CREATE TABLE Destinatario_Messaggio(
  cfPersonaleDest char(16),
  mailPersonaleDest VARCHAR(30),
  cfPersonaleMitt char(16),
  mailPersonaleMitt varchar(30),
  TimestMesssaggio TIMESTAMP,
  PRIMARY KEY ( cfPersonaleDest, cfPersonaleMitt, TimestMesssaggio),
  FOREIGN KEY (cfPersonaleDest, mailPersonaleDest) REFERENCES Personale(personale_CFPersona, mail) on delete cascade on update cascade,
  FOREIGN KEY (TimestMesssaggio, cfPersonaleMitt, mailPersonaleMitt) REFERENCES Messaggio(Timest, personale_Mitt, personale_mail_mitt) on delete cascade on update cascade
);

CREATE TABLE Magazzino_Farmaco(
  quantita integer,
  nomeFarmaciaMagazzino VARCHAR(30),
  indirizzoFarmaciaMagazzino VARCHAR(30),
  cfTitolareFarmaciaMagazzino CHAR(16),
  codiceFarmaco varchar(10),
  PRIMARY KEY (nomeFarmaciaMagazzino, indirizzoFarmaciaMagazzino, cfTitolareFarmaciaMagazzino, codiceFarmaco),
  FOREIGN KEY (nomeFarmaciaMagazzino, indirizzoFarmaciaMagazzino, cfTitolareFarmaciaMagazzino) REFERENCES Magazzino(nomeFarmacia, indirizzoFarmacia, cfTitolareFarmacia) on delete cascade on update cascade,
  FOREIGN KEY (codiceFarmaco) REFERENCES Farmaco(Codice) on delete cascade on update cascade
);

CREATE TABLE Acquisto_Farmaco(
  quantita integer,
  timestAcquisto TIMESTAMP,
  cfPersonaleAcquisto CHAR(16),
  codiceFarmacoAcquisto varchar(10),
  PRIMARY KEY (timestAcquisto, cfPersonaleAcquisto, codiceFarmacoAcquisto),
  FOREIGN KEY (timestAcquisto, cfPersonaleAcquisto) REFERENCES Acquisto(timest, cfPersonale) on delete cascade on update cascade,
  FOREIGN KEY (codiceFarmacoAcquisto) REFERENCES Farmaco(Codice) on delete cascade on update cascade
);

--alter table Personale add foreign key(nomeFarmacia, indirizzoFarmacia, CF_titolare_farmacia) references Farmacia(nome, indirizzo, cfTitolare) on delete set null on update cascade;
--alter table Farmacia add FOREIGN KEY (cfTitolare, mailTitolare) REFERENCES Personale(personale_CFPersona, mail) on delete no action on update cascade;