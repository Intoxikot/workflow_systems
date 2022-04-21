-- postgresql 10

CREATE DATABASE workflow_technology
    WITH 
    OWNER = root
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE SCHEMA IF NOT EXISTS store; 

DROP TABLE IF EXISTS store.product;
DROP TABLE IF EXISTS store.income;
DROP TABLE IF EXISTS store.outcome;
DROP TABLE IF EXISTS store.document;
DROP TABLE IF EXISTS store.inventory_item;

CREATE SEQUENCE IF NOT EXISTS store.product_id_seq;
CREATE SEQUENCE IF NOT EXISTS store.income_id_seq;
CREATE SEQUENCE IF NOT EXISTS store.outcome_id_seq;
CREATE SEQUENCE IF NOT EXISTS store.document_id_seq;
CREATE SEQUENCE IF NOT EXISTS store.inventory_item_id_seq;

CREATE TABLE IF NOT EXISTS store.product (
	product_id int NOT NULL 
	DEFAULT NEXTVAL('store.product_id_seq'::regclass),
	name character varying NOT NULL,
	CONSTRAINT product_pk 
		PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS store.document (
	document_id int NOT NULL
	DEFAULT NEXTVAL('store.document_id_seq'::regclass),
	code character varying NOT NULL UNIQUE,
	date timestamp without time zone NOT NULL,
	CONSTRAINT "document_pk" 
		PRIMARY KEY ("document_id")
);

CREATE TABLE IF NOT EXISTS store.income (
	income_id bigint NOT NULL
	DEFAULT NEXTVAL('store.income_id_seq'::regclass),
	product_id int NOT NULL,
	document_id int NOT NULL,
	count numeric(8,4) NOT NULL,
	cost numeric(16,8) NOT NULL,
	CONSTRAINT income_pk  
		PRIMARY KEY (income_id),
	CONSTRAINT income_fk0
		FOREIGN KEY (product_id) 
		REFERENCES store.product (product_id),
	CONSTRAINT income_fk1 
		FOREIGN KEY (document_id) 
		REFERENCES store.document (document_id)
);

CREATE TABLE IF NOT EXISTS store.outcome (
	outcome_id bigint NOT NULL
	DEFAULT NEXTVAL('store.outcome_id_seq'::regclass),
	product_id int NOT NULL,
	document_id int NOT NULL,
	count numeric(8,4) NOT NULL,
	cost numeric(16,8) NOT NULL,
	CONSTRAINT outcome_pk
		PRIMARY KEY (outcome_id),
	CONSTRAINT outcome_fk0
		FOREIGN KEY (product_id) 
		REFERENCES store.product (product_id),
	CONSTRAINT outcome_fk1
		FOREIGN KEY (document_id) 
		REFERENCES store.document (document_id)
);

CREATE TABLE IF NOT EXISTS store.inventory_item (
	"item_id" bigint NOT NULL
	DEFAULT NEXTVAL('store.inventory_item_id_seq'::regclass),
	"document_id" int NOT NULL,
	"product_id" int NOT NULL,
	"count" numeric(8,4) NOT NULL,
	CONSTRAINT "inventory_item_id_pk" 
		PRIMARY KEY ("item_id"),
	CONSTRAINT inventory_item_fk0 
		FOREIGN KEY (document_id) 
		REFERENCES store.document (document_id),
	CONSTRAINT inventory_item_fk1
		FOREIGN KEY (product_id) 
		REFERENCES store.product(product_id)
);