CREATE TABLE "store.product" (
	"product_id" serial NOT NULL,
	"name" varchar NOT NULL,
	CONSTRAINT "product_pk" PRIMARY KEY ("product_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "store.income" (
	"income_id" serial NOT NULL,
	"product_id" integer NOT NULL,
	"document_id" integer NOT NULL,
	"count" FLOAT NOT NULL,
	"cost" FLOAT NOT NULL,
	CONSTRAINT "income_pk" PRIMARY KEY ("income_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "store.outcome" (
	"outcome_id" serial NOT NULL,
	"product_id" integer NOT NULL,
	"document_id" integer NOT NULL,
	"count" serial NOT NULL,
	"cost" FLOAT NOT NULL,
	CONSTRAINT "outcome_pk" PRIMARY KEY ("outcome_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "store.document" (
	"document_id" serial NOT NULL,
	"code" varchar NOT NULL UNIQUE,
	"date" DATETIME NOT NULL,
	CONSTRAINT "document_pk" PRIMARY KEY ("document_id")
) WITH (
  OIDS=FALSE
);

CREATE TABLE "store.inventory_item" (
	"storage_id" serial NOT NULL,
	"document_id" integer NOT NULL,
	"product_id" integer NOT NULL,
	"count" FLOAT NOT NULL,
	CONSTRAINT "inventory_item_pk" PRIMARY KEY ("storage_id")
) WITH (
  OIDS=FALSE
);

ALTER TABLE "income" ADD CONSTRAINT "income_fk0" FOREIGN KEY ("product_id") REFERENCES "product"("product_id");
ALTER TABLE "income" ADD CONSTRAINT "income_fk1" FOREIGN KEY ("document_id") REFERENCES "document"("document_id");

ALTER TABLE "outcome" ADD CONSTRAINT "outcome_fk0" FOREIGN KEY ("product_id") REFERENCES "product"("product_id");
ALTER TABLE "outcome" ADD CONSTRAINT "outcome_fk1" FOREIGN KEY ("document_id") REFERENCES "document"("document_id");


ALTER TABLE "inventory_item" ADD CONSTRAINT "inventory_item_fk0" FOREIGN KEY ("document_id") REFERENCES "document"("document_id");
ALTER TABLE "inventory_item" ADD CONSTRAINT "inventory_item_fk1" FOREIGN KEY ("product_id") REFERENCES "product"("product_id");





