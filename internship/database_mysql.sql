CREATE TABLE `product` (
	`product_id` INT NOT NULL AUTO_INCREMENT,
	`name` varchar NOT NULL,
	PRIMARY KEY (`product_id`)
);

CREATE TABLE `income` (
	`income_id` INT NOT NULL AUTO_INCREMENT,
	`product_id` INT NOT NULL,
	`document_id` INT NOT NULL,
	`count` FLOAT NOT NULL,
	`cost` FLOAT NOT NULL,
	PRIMARY KEY (`income_id`)
);

CREATE TABLE `outcome` (
	`outcome_id` INT NOT NULL AUTO_INCREMENT,
	`product_id` INT NOT NULL,
	`document_id` INT NOT NULL,
	`count` FLOAT NOT NULL AUTO_INCREMENT,
	`cost` FLOAT NOT NULL,
	PRIMARY KEY (`outcome_id`)
);

CREATE TABLE `document` (
	`document_id` INT NOT NULL AUTO_INCREMENT,
	`code` varchar NOT NULL UNIQUE,
	`date` DATETIME NOT NULL,
	PRIMARY KEY (`document_id`)
);

CREATE TABLE `inventory_item` (
	`item_id` INT NOT NULL AUTO_INCREMENT,
	`document_id` INT NOT NULL,
	`product_id` INT NOT NULL,
	`count` FLOAT NOT NULL,
	PRIMARY KEY (`item_id`)
);

ALTER TABLE `income` ADD CONSTRAINT `income_fk0` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);

ALTER TABLE `income` ADD CONSTRAINT `income_fk1` FOREIGN KEY (`document_id`) REFERENCES `document`(`document_id`);

ALTER TABLE `outcome` ADD CONSTRAINT `outcome_fk0` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);

ALTER TABLE `outcome` ADD CONSTRAINT `outcome_fk1` FOREIGN KEY (`document_id`) REFERENCES `document`(`document_id`);

ALTER TABLE `inventory_item` ADD CONSTRAINT `inventory_item_fk0` FOREIGN KEY (`document_id`) REFERENCES `document`(`document_id`);

ALTER TABLE `inventory_item` ADD CONSTRAINT `inventory_item_fk1` FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`);





