-- Creation of tables...
-- Creation of users table...
CREATE DATABASE enterprise;
\c enterprise;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50),
  lastname VARCHAR(50),
  username VARCHAR(50) UNIQUE,
  password VARCHAR(500),
  company VARCHAR(100),
  position VARCHAR(50),
  department VARCHAR(50),
  email VARCHAR(50),
  phone1 VARCHAR(50),
  phone2 VARCHAR(50),
  usertype VARCHAR(100),
  status VARCHAR(10)
);

-- Creation of logistics tables...
CREATE TABLE providers(
	id SERIAL NOT NULL PRIMARY KEY,
	name VARCHAR(50) UNIQUE,
	address VARCHAR(50),
	phone_1 VARCHAR(20),
	phone_2 VARCHAR(20),
	email VARCHAR(50),
	pobox VARCHAR(10),
	description varchar(2000)
);

CREATE TABLE grp(
  id SERIAL PRIMARY KEY,
  groupname VARCHAR(100) UNIQUE,
  description TEXT
);

CREATE TABLE items(
  id SERIAL PRIMARY KEY,
  code VARCHAR(20) UNIQUE,
  item VARCHAR(50),
  brand VARCHAR(10),
  provider VARCHAR(50),
  unit VARCHAR(5),
  unit_price REAL,
  description TEXT,
  size VARCHAR(5),
  color VARCHAR(10),
  sku VARCHAR(25),
  part_number VARCHAR(25),
  ieme VARCHAR(25),
  lengh REAL,
  width REAL,
  height REAL,
  diameter REAL,
  l_unit VARCHAR(10),
  w_unit VARCHAR(10),
  h_unit VARCHAR(10),
  d_unit VARCHAR(10),
  grp VARCHAR(50),
  category VARCHAR(50)
);

CREATE TABLE packages(
  id SERIAL PRIMARY KEY,
  packagecode VARCHAR(20) UNIQUE,
  packagename VARCHAR(50) UNIQUE,
  itemcode VARCHAR(50),
  itemname VARCHAR(50),
  unit VARCHAR(10),
  quantity REAL,
  description TEXT
);

CREATE TABLE warehouses(
  id SERIAL PRIMARY KEY,
  location VARCHAR(50),
  code VARCHAR(100) UNIQUE,
  name VARCHAR(100),
  description TEXT
);

CREATE TABLE bins(
  id SERIAL PRIMARY KEY,
  code VARCHAR(50) UNIQUE,
  name VARCHAR(100),
  warehouse VARCHAR(100),
  description TEXT,
  status VARCHAR(10)
);

CREATE TABLE Transactions(
	ID SERIAL NOT NULL PRIMARY KEY,
	CreatedOn DATE,
	CreatedBy VARCHAR(50),
	EditedOn DATE,
	EditedBy VARCHAR(50),
	Type VARCHAR(10),
	ItemCode VARCHAR(20),
	ItemName VARCHAR(50),
	Warehouse VARCHAR(100),
	Bin VARCHAR(100),
	Unit VARCHAR(5),
	Quantity REAL,
	Status VARCHAR(15)
  packagecode VARCHAR(20),
  packagename VARCHAR(50)
);

CREATE TABLE Inventory(
	Line SERIAL NOT NULL PRIMARY KEY,
	ItemCode VARCHAR(20),
	ItemName VARCHAR(50),
	Warehouse VARCHAR(100),
	Block VARCHAR(100),
	Section VARCHAR(100),
	Shelf VARCHAR(100),
	Bin VARCHAR(100),
	Unit VARCHAR(5),
	Quantity REAL,
	lastUpdate DATE,
	UnitPrice REAL,
	BulkPrice REAL
);

-- addition of foreign keys...
-- addition of foreign keys for logistics.
ALTER TABLE items ADD FOREIGN KEY(provider) REFERENCES providers(name);
ALTER TABLE items ADD FOREIGN KEY(grp) REFERENCES grp(groupname);
ALTER TABLE packages ADD FOREIGN KEY(itemcode) REFERENCES items(code);
ALTER TABLE bins ADD FOREIGN KEY(warehouse) REFERENCES warehouses(code);
ALTER TABLE Transactions ADD FOREIGN KEY(createdby) REFERENCES users(username);
ALTER TABLE Transactions ADD FOREIGN KEY(editedby) REFERENCES users(username);
ALTER TABLE Transactions ADD FOREIGN KEY(ItemCode) REFERENCES Items(code);
ALTER TABLE Transactions ADD FOREIGN KEY(warehouse) REFERENCES Warehouses(code);
ALTER TABLE Transactions ADD FOREIGN KEY(bin) REFERENCES bins(code);
ALTER TABLE Inventory ADD FOREIGN KEY(ItemCode) REFERENCES Items(code);
ALTER TABLE Inventory ADD FOREIGN KEY(warehouse) REFERENCES Warehouses(code);
ALTER TABLE Inventory ADD FOREIGN KEY(bin) REFERENCES Bins(code);
