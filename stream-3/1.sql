DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
	card_id bigint NOT NULL,
	customer_id bigint NOT NULL,
	price varchar(10),
	product_id bigint,
	timestamp timestamp)
	diststyle all;

