CREATE TABLE olist_customers_dataset (
customer_id TEXT PRIMARY KEY,
customer_unique_id TEXT,
customer_zip_code_prefix INTEGER,
customer_city TEXT,
customer_state TEXT
);

CREATE TABLE olist_orders_dataset (
order_id TEXT PRIMARY KEY,
customer_id TEXT,
order_status TEXT,
order_purchase_timestamp TIMESTAMP,
order_approved_at TIMESTAMP,
order_delivered_carrier_date TIMESTAMP,
order_delivered_customer_date TIMESTAMP,
order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE olist_order_items_dataset (
order_id TEXT,
order_item_id INTEGER,
product_id TEXT,
seller_id TEXT,
shipping_limit_date TIMESTAMP,
price NUMERIC,
freight_value NUMERIC
);

CREATE TABLE olist_order_payments_dataset (
order_id TEXT,
payment_sequential INTEGER,
payment_type TEXT,
payment_installments INTEGER,
payment_value NUMERIC
);

CREATE TABLE olist_order_reviews_dataset (
review_id TEXT,
order_id TEXT,
review_score INTEGER,
review_comment_title TEXT,
review_comment_message TEXT,
review_creation_date TIMESTAMP,
review_answer_timestamp TIMESTAMP
);

CREATE TABLE olist_products_dataset (
product_id TEXT PRIMARY KEY,
product_category_name TEXT,
product_name_lenght INTEGER,
product_description_lenght INTEGER,
product_photos_qty INTEGER,
product_weight_g NUMERIC,
product_length_cm NUMERIC,
product_height_cm NUMERIC,
product_width_cm NUMERIC
);


CREATE TABLE olist_sellers_dataset (
seller_id TEXT PRIMARY KEY,
seller_zip_code_prefix INTEGER,
seller_city TEXT,
seller_state TEXT
);


CREATE TABLE olist_geolocation_dataset (
geolocation_zip_code_prefix INTEGER,
geolocation_lat NUMERIC,
geolocation_lng NUMERIC,
geolocation_city TEXT,
geolocation_state TEXT
);
