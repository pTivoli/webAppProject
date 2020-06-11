create table Persona(
  codiceFiscale char(16) primary key,
  nome varchar(20) not null,
  cognome varchar(20) not null,
  dataNascita date
);


create table Medico(
  codiceRegionale varchar(10),
  medico_CFPersona char(16),
  primary key(codiceRegionale, medico_Persona),
  foreign key medico_Persona references Persona(codiceFiscale) on delete cascade
);


create table Persoale(
  mail varchar(30),
  pwd varchar(20),
  personale_CFPersona char(16),
  primary key(personale_CFPersona),
  foreign key personale_CFPersona references Persona(codiceFiscale) on delete cascade
)

create table Ricetta(
   codiceRicetta varchar(10),
   data date,
   codiceFiscale char(11),        --per le persone giuridiche la lunghezza del cf è 16 caratteri
   ricetta_Codice_Medico varchar(10),
   ricetta_Medico_Persona char(16),
  primary key(codiceRicetta, ricetta_Codice_Medico, ricetta_Medico_Persona),
  foreign key ricetta_Codice_Medico, ricetta_Medico_Persona references Medico(codiceRegionale, medico_Persona) on delete cascade
)
