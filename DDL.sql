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
  cfPersonale CHAR(16),
  mailPersonale VARCHAR(30),
  PRIMARY KEY (nome, indirizzo, cfPersonale, mailPersonale),
  FOREIGN KEY (cfPersonale, mailPersonale) REFERENCES Personale(personale_CFPersona, mail)
);