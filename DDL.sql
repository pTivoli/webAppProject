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
  foreign key (medico_CFPersona) references Persona(codiceFiscale)
  on delete cascade --da valutare (può essere anche un paziente il medico)
);


create table Personale(
  mail varchar(30),
  pwd varchar(20),
  personale_CFPersona char(16),
  ruolo VARCHAR(30),
  primary key(personale_CFPersona, mail),
  foreign key (personale_CFPersona) references Persona(codiceFiscale),
  FOREIGN KEY (ruolo) REFERENCES Ruolo(nome)
  on delete cascade --same thing of before
);

create table Ruolo(
  nome VARCHAR(30) PRIMARY KEY
)

create table Ricetta(
   codiceRicetta varchar(10),
   data date,
   codiceFiscale char(11),        --per le persone giuridiche la lunghezza del cf è 16 caratteri
   ricetta_Codice_Medico varchar(10),
   ricetta_Medico_Persona char(16),
  primary key(codiceRicetta, ricetta_Codice_Medico, ricetta_Medico_Persona),
  foreign key (ricetta_Codice_Medico, ricetta_Medico_Persona) references Medico(codiceRegionale, medico_Persona)
);

create table Acquisto(
  timest TIMESTAMP,
  mailPersonale VARCHAR(30),
  cfPersonale CHAR(16),
  cfPersona CHAR(16),
  totale INTEGER,
  PRIMARY KEY (times, mailPersonale, cfPersonale),
  FOREIGN KEY (cfPersona) REFERENCES Persona(codiceFiscale),
  FOREIGN KEY (mailPersonale, cfPersonale) REFERENCES  Personale(mail, personale_CFPersona)
);

create table Farmacia(
  nome VARCHAR(30),
  indirizzo VARCHAR(30),
  telefono VARCHAR(15),
  cfTitolare CHAR(16),
  mailTitolare VARCHAR(30),
  PRIMARY KEY (nome, indirizzo, cfTitolare, mailTitolare),
  FOREIGN KEY (cfTitolare, mailTitolare) REFERENCES Personale(personale_CFPersona, mail)
);

create TABLE Magazzino(
  nomeFarmacia VARCHAR(30),
  indirizzoFarmacia VARCHAR(30),
  cfTitolareFarmacia CHAR(16),
  mailTitolareFarmacia VARCHAR(30),
  PRIMARY KEY (nomeFarmacia, indirizzoFarmacia, cfTitolareFarmacia, mailTitolareFarmacia) ,
  FOREIGN KEY (nomeFarmacia, indirizzoFarmacia, cfTitolareFarmacia, mailTitolareFarmacia) REFERENCES Farmacia(nome, indirizzo, cfTitolare, mailTitolare)
);

CREATE TABLE Farmaco(
  Codice  varchar(10),
  Nome VARCHAR(20),
  Prezzo decimal(5,2),
  ObbligoRicetta boolean DEFAULT false,
  Scadenza date
);

CREATE TABLE Messaggio(
  Timestamp TIMESTAMP,
  Testo VARCHAR(300),
  mailPersonale varchar(30),
  personale_CFPersonaM char(16),
  PRIMARY KEY (Timestamp, mailPersonale, personale_CFPersonaM),
  FOREIGN KEY (mailPersonale, personale_CFPersonaM) REFERENCES Persona(personale_CFPersona, mail)

);
