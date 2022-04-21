CREATE SCHEMA store; 

DROP TABLE IF EXISTS store.inventory_item;
DROP TABLE IF EXISTS store.income;
DROP TABLE IF EXISTS store.outcome;
DROP TABLE IF EXISTS store.document;
DROP TABLE IF EXISTS store.product;

DROP SEQUENCE IF EXISTS store.product_id_seq;
DROP SEQUENCE IF EXISTS store.document_id_seq;
DROP SEQUENCE IF EXISTS store.income_id_seq;
DROP SEQUENCE IF EXISTS store.outcome_id_seq;
DROP SEQUENCE IF EXISTS store.inventory_item_id_seq;

CREATE SEQUENCE store.product_id_seq;
CREATE SEQUENCE store.income_id_seq;
CREATE SEQUENCE store.outcome_id_seq;
CREATE SEQUENCE store.document_id_seq;
CREATE SEQUENCE store.inventory_item_id_seq;

CREATE TABLE store.product (
	product_id int NOT NULL 
	DEFAULT NEXTVAL('store.product_id_seq'::regclass),
	name character varying NOT NULL,
	CONSTRAINT product_pk 
		PRIMARY KEY (product_id)
);

CREATE TABLE store.document (
	document_id int NOT NULL
	DEFAULT NEXTVAL('store.document_id_seq'::regclass),
	code character varying NOT NULL UNIQUE,
	date timestamp without time zone NOT NULL,
	CONSTRAINT "document_pk" 
		PRIMARY KEY ("document_id")
);

CREATE TABLE store.income (
	income_id bigint NOT NULL
	DEFAULT NEXTVAL('store.income_id_seq'::regclass),
	document_id int NOT NULL,
	product_id int NOT NULL,
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

CREATE TABLE store.outcome (
	outcome_id bigint NOT NULL
	DEFAULT NEXTVAL('store.outcome_id_seq'::regclass),
	document_id int NOT NULL,
	product_id int NOT NULL,
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

CREATE TABLE store.inventory_item (
	item_id bigint NOT NULL
	DEFAULT NEXTVAL('store.inventory_item_id_seq'::regclass),
	document_id int NOT NULL,
	product_id int NOT NULL,
	count numeric(8,4) NOT NULL,
	CONSTRAINT "inventory_item_id_pk" 
		PRIMARY KEY ("item_id"),
	CONSTRAINT inventory_item_fk0 
		FOREIGN KEY (document_id) 
		REFERENCES store.document (document_id),
	CONSTRAINT inventory_item_fk1
		FOREIGN KEY (product_id) 
		REFERENCES store.product(product_id)
);

SELECT * FROM store.product;
SELECT * FROM store.document;
SELECT * FROM store.income;
SELECT * FROM store.outcome;
SELECT * FROM store.inventory_item;