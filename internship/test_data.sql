INSERT INTO store.product (name) VALUES ('Автошина Continental');

INSERT INTO store.document (code, date) VALUES ('Поступление 1', '2022.01.10 10:00');
INSERT INTO store.document (code, date) VALUES ('Поступление 2', '2022.01.11 12:00');
INSERT INTO store.document (code, date) VALUES ('Отгрузка 1', '2022.02.12 12:00');
INSERT INTO store.document (code, date) VALUES ('Отгрузка 2', '2022.03.14 14:00');

INSERT INTO store.income (document_id, product_id, count, cost) VALUES (1, 1, 10, 1000);
INSERT INTO store.income (document_id, product_id, count, cost) VALUES (2, 1, 1, 1000);

INSERT INTO store.outcome (document_id, product_id, count, cost) VALUES (3, 1, 3, 800);
INSERT INTO store.outcome (document_id, product_id, count, cost) VALUES (4, 1, 7, 1500);