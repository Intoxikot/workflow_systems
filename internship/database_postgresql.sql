DROP SCHEMA IF EXISTS store CASCADE;
CREATE SCHEMA store; 

DROP TABLE IF EXISTS store.product CASCADE;
DROP TABLE IF EXISTS store.income CASCADE;
DROP TABLE IF EXISTS store.outcome CASCADE;
DROP TABLE IF EXISTS store.inventory CASCADE;
DROP TABLE IF EXISTS store.income_item CASCADE;
DROP TABLE IF EXISTS store.outcome_item CASCADE;
DROP TABLE IF EXISTS store.inventory_item CASCADE;

DROP SEQUENCE IF EXISTS store.product_id_seq;
DROP SEQUENCE IF EXISTS store.income_document_id_seq;
DROP SEQUENCE IF EXISTS store.outcome_document_id_seq;
DROP SEQUENCE IF EXISTS store.inventory_document_id_seq;
DROP SEQUENCE IF EXISTS store.income_item_id_seq;
DROP SEQUENCE IF EXISTS store.outcome_item_id_seq;
DROP SEQUENCE IF EXISTS store.inventory_item_id_seq;

CREATE SEQUENCE store.product_id_seq;
CREATE SEQUENCE store.income_document_id_seq;
CREATE SEQUENCE store.outcome_document_id_seq;
CREATE SEQUENCE store.inventory_document_id_seq;
CREATE SEQUENCE store.income_item_id_seq;
CREATE SEQUENCE store.outcome_item_id_seq;
CREATE SEQUENCE store.inventory_item_id_seq;

CREATE TABLE store.product (
	product_id int NOT NULL 
	DEFAULT NEXTVAL('store.product_id_seq'::regclass),
	name character varying NOT NULL,
	CONSTRAINT product_pk 
		PRIMARY KEY (product_id)
);

CREATE TABLE store.income (
	document_id int NOT NULL
	DEFAULT NEXTVAL('store.income_document_id_seq'::regclass),
	code character varying NOT NULL UNIQUE,
	date timestamp without time zone NOT NULL,
	CONSTRAINT income_pk 
		PRIMARY KEY (document_id)
);

CREATE TABLE store.outcome (
	document_id int NOT NULL
	DEFAULT NEXTVAL('store.outcome_document_id_seq'::regclass),
	code character varying NOT NULL UNIQUE,
	date timestamp without time zone NOT NULL,
	CONSTRAINT outcome_pk 
		PRIMARY KEY (document_id)
);

CREATE TABLE store.inventory (
	document_id int NOT NULL
	DEFAULT NEXTVAL('store.inventory_document_id_seq'::regclass),
	code character varying NOT NULL UNIQUE,
	date timestamp without time zone NOT NULL,
	CONSTRAINT inventory_pk 
		PRIMARY KEY (document_id)
);

CREATE TABLE store.income_item (
	item_id bigint NOT NULL
	DEFAULT NEXTVAL('store.income_item_id_seq'::regclass),
	document_id int NOT NULL,
	product_id int NOT NULL,
	count numeric(8,4) NOT NULL,
	cost numeric(16,8) NOT NULL,
	CONSTRAINT income_item_pk  
		PRIMARY KEY (item_id),
	CONSTRAINT income_item_fk0
		FOREIGN KEY (product_id) 
		REFERENCES store.product (product_id),
	CONSTRAINT income_item_fk1 
		FOREIGN KEY (document_id) 
		REFERENCES store.income (document_id)
);

CREATE TABLE store.outcome_item (
	item_id bigint NOT NULL
	DEFAULT NEXTVAL('store.outcome_item_id_seq'::regclass),
	document_id int NOT NULL,
	product_id int NOT NULL,
	count numeric(8,4) NOT NULL,
	cost numeric(16,8) NOT NULL,
	CONSTRAINT outcome_item_pk
		PRIMARY KEY (item_id),
	CONSTRAINT outcome_item_fk0
		FOREIGN KEY (product_id) 
		REFERENCES store.product (product_id),
	CONSTRAINT outcome_item_fk1
		FOREIGN KEY (document_id) 
		REFERENCES store.outcome (document_id)
);

CREATE TABLE store.inventory_item (
	item_id bigint NOT NULL
	DEFAULT NEXTVAL('store.inventory_item_id_seq'::regclass),
	document_id int NOT NULL,
	product_id int NOT NULL,
	count numeric(8,4) NOT NULL,
	CONSTRAINT inventory_item_pk 
		PRIMARY KEY (item_id),
	CONSTRAINT inventory_item_fk0
		FOREIGN KEY (product_id) 
		REFERENCES store.product (product_id),
	CONSTRAINT inventory_item_fk1
		FOREIGN KEY (document_id) 
		REFERENCES store.inventory (document_id)
);

SELECT * FROM store.product;
SELECT * FROM store.document;
SELECT * FROM store.income;
SELECT * FROM store.outcome;
SELECT * FROM store.inventory;
SELECT * FROM store.income_item;
SELECT * FROM store.outcome_item;
SELECT * FROM store.inventory_item;