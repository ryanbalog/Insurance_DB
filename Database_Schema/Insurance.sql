/* Create statements for each relation in the db */

Create table Policies (
  policyID INT not null auto_increment,
  policyName VARCHAR(30) not null,
  description VARCHAR(200),
  constraint policy_PK Primary Key(policyID)
);

Create table Policy_Accounts (
  policyAccountID INT not null auto_increment,
  policyID INT not null,
  constraint account_PK Primary Key(policyAccountID),
  constraint policy_FK Foreign Key(policyID) references Policies(policyID)
);

Create table Account_Members (
  policyAccountID INT not null,
  memberID INT not null,
  firstName VARCHAR(20) not null,
  lastName VARCHAR(20) not null,
  DOB date not null,
  SSN INT(9) not null,
  streetAddress VARCHAR(45) not null,
  city VARCHAR(45) not null,
  state CHAR(2) not null,
  constraint unique(SSN),
  constraint member_PK Primary Key(policyAccountID, memberID),
  constraint account_FK Foreign Key(policyAccountID) references Policy_Accounts(policyAccountID)
);

Create table Providers (
  providerID INT not null auto_increment,
  firstName VARCHAR(20) not null,
  lastName VARCHAR(20) not null,
  doctorType CHAR(5) not null,
  NPI INT(10) not null,
  streetAddress VARCHAR(45) not null,
  city VARCHAR(20) not null,
  state CHAR(2)not null,
  insuranceProvider BOOLEAN not null,
  constraint unique(NPI),
  constraint provider_PK Primary Key(providerID)
);

Create table Service (
  serviceID INT not null auto_increment,
  serviceDate DATE not null,
  providerID INT not null,
  policyAccountID INT not null,
  memberID INT not null,
  constraint service_PK Primary Key(serviceID),
  constraint provider_FK Foreign Key(providerID) references Providers(providerID),
  constraint member_FK Foreign Key(policyAccountID, memberID) references Account_Members(policyAccountID, memberID)
);

Create table ICD_Codes (
  ICD VARCHAR(8) not null,
  name VARCHAR(45) not null,
  description VARCHAR(100),
  constraint icd_PK Primary Key(ICD)
);

Create table CPT_Codes (
  CPT CHAR(6) not null,
  name VARCHAR(45)not null,
  description VARCHAR(100),
  constraint cpt_FK Primary Key(CPT)
);

Create table Service_Items (
  serviceID INT not null,
  lineID INT not null,
  ICD VARCHAR(8) null,
  CPT CHAR(6) null,
  description VARCHAR(50),
  constraint item_PK Primary Key(serviceID, lineID),
  constraint service_FK Foreign Key(serviceID) references Service(serviceID),
  constraint icd_FK Foreign Key(ICD) references ICD_Codes(ICD),
  constraint cpt_FK Foreign Key(CPT) references CPT_Codes(CPT)
);
