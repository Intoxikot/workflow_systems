INSERT INTO store.product (name) VALUES ('Автошина Continental');
INSERT INTO store.product (name) VALUES ('Автошина ProExpert');

INSERT INTO store.income (code, date) VALUES ('Поступление 1', '2022.01.10 10:00');
INSERT INTO store.income (code, date) VALUES ('Поступление 2', '2022.01.11 12:00');

INSERT INTO store.outcome (code, date) VALUES ('Отгрузка 1', '2022.02.12 12:00');
INSERT INTO store.outcome (code, date) VALUES ('Отгрузка 2', '2022.03.14 14:00');

INSERT INTO store.income_item (document_id, product_id, count, cost) VALUES (1, 1, 10, 1000);
INSERT INTO store.income_item (document_id, product_id, count, cost) VALUES (2, 1, 1, 1200);

INSERT INTO store.outcome_item (document_id, product_id, count, cost) VALUES (1, 1, 3, 800);
INSERT INTO store.outcome_item (document_id, product_id, count, cost) VALUES (2, 1, 7, 1500);