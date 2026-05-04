\copy olist_customers_dataset
FROM '/data/datasets/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

\copy olist_orders_dataset
FROM '/data/datasets/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

\copy olist_order_items_dataset
FROM '/data/datasets/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

\copy olist_order_payments_dataset
FROM '/data/datasets/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

\copy olist_order_reviews_dataset
FROM '/data/datasets/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

\copy olist_products_dataset
FROM '/data/datasets/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

\copy olist_sellers_dataset
FROM '/data/datasets/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

\copy olist_geolocations_dataset
FROM '/data/datasets/olist_geolocations_dataset.csv'
DELIMITER ','
CSV HEADER;





