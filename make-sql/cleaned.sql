###Mengecek keseluruhan table
select * from olist_orders_dataset ood; 
select * from olist_order_items_dataset; 
select * from olist_customers_dataset ocd;
select * from olist_order_reviews_dataset oord ;
select * from olist_products_dataset opd;
select * from olist_order_payments_dataset oopd;
select * from olist_sellers_dataset osd;
select * from olist_geolocation_dataset ogd;


###check missing value from olist_orders_dataset
#tidak perlu dibersihkan missing value hanya 2 baris
select order_status, 
       COUNT(*) as total_orders 
from olist_orders_dataset ood
where order_delivered_carrier_date is null
group by order_status
order by total_orders desc;

#tidak perlu dibersihkan missing value hanya 8 baris
select order_status, 
       COUNT(*) 
from olist_orders_dataset ood
where ood.order_delivered_customer_date  is null
group by order_status;

#tidak perlu dibersihkan missing value hanya 14 baris
select order_status, 
       COUNT(*) 
from olist_orders_dataset ood
where ood.order_approved_at  is null
group by order_status;

#tidak ada missing value di kolom customer id
select COUNT(*)
from olist_orders_dataset ood
where ood.customer_id is null;

###check duplicate from olist orders_dataset

#tidak ada duplicate order id 
select order_id,
       COUNT(*)
from olist_orders_dataset ood
group by ood.order_id
having COUNT(*) > 1;

#tidak ada duplicat di table olist_order_dataset
select count(*) as duplicate_order
from (
select order_id,
       COUNT(*)
from olist_orders_dataset ood
group by ood.order_id
having COUNT(*) > 1
);

###check data aneh dar olist_orders_dataset

#mengecek apakah ada penerimaan duluan dari pada pembelian
select *
from olist_orders_dataset ood 
where ood.order_approved_at < ood.order_purchase_timestamp 

#terdapat 166 baris anomaly barang dikirim sebelum dibeli
select *
from olist_orders_dataset ood 
where ood.order_delivered_carrier_date < ood.order_purchase_timestamp; 

#penanggulangan data anomaly barang dikirim sebelum dibeli
select *,
case
	when order_delivered_carrier_date < order_purchase_timestamp
	then 'anomaly'
	else 'valid'
end as date_validation
from olist_orders_dataset ood; 

#terdapat gap 171 hari yang sangat anomaly dan sisanya anomaly biasa
select order_id,
       order_purchase_timestamp,
       order_delivered_carrier_date,
       (order_purchase_timestamp - order_delivered_carrier_date) as	time_gap
from olist_orders_dataset ood 
where ood.order_delivered_carrier_date < ood.order_purchase_timestamp 
order by time_gap desc;       

#penanggulangan gap anomaly
select *,
case 
	when (order_purchase_timestamp - order_delivered_carrier_date) > interval '1 day'
	then 'serve_anomaly'
	when order_delivered_carrier_date < order_purchase_timestamp
	then 'minor_anomaly'
	else 'valid'
end anomaly_flag
from olist_orders_dataset ood 
	

###check missing value, dan data aneh dari table olist_order_items_dataset

#tidak ada duplicate id
select order_id,
       order_item_id,
       COUNT(*)
from olist_order_items_dataset ooid
group by ooid.order_id,
         order_item_id          
having COUNT(*) > 1;

#tidak ada price minus dan 0
select *
from olist_order_items_dataset ooid
where price <= 0;

#tidak ada freight value dibawah 0
select *
from olist_order_items_dataset ooid 
where freight_value <0;


#cek high price outlier, tidak perlu di hapus karena normal
with q as (
select
percentile_cont(0.25) within group (order by price) as q1,
percentile_cont(0.75) within group (order by price) as q3
from olist_order_items_dataset ooid 
)
select *
from olist_order_items_dataset, q
where price > (q3 + 1.5*(q3-q1))
order by price desc;

#mengecek max price apakah muncul sekali atau berulang
select product_id,
COUNT(*) as freq,
AVG(price) as avg_price,
MAX(price) as max_price
from olist_order_items_dataset ooid
where price > 244.4
group by product_id
order by avg_price DESC
LIMIT(20);


###mengecek foreign key integrity

#mengecek order ada tapi customer tidak ada
select COUNT(*)
from olist_orders_dataset ood
left join olist_customers_dataset ocd
on  ood.customer_id = ocd.customer_id 
where ocd.customer_id is null;

#mengecek order item ada tetapi order parent tidak ada
select COUNT(*)
from olist_order_items_dataset ooid
left join olist_orders_dataset ood 
on ooid.order_id = ood.order_id 
where ood.order_id is null;

#mengecek product di order item tetapi tidak ada di product
select COUNT(*)
from olist_order_items_dataset ooid 
left join olist_products_dataset opd
on ooid.product_id = opd.product_id 
where opd.product_id is null;

#mengecek seller di order item tetapi tidak ada di seller
select COUNT(*)
from olist_order_items_dataset ooid 
left join olist_sellers_dataset osd 
on ooid.seller_id = osd.seller_id 
where osd.seller_id is null;

#mengecek pembayaran tanpa order
select COUNT(*)
from olist_order_payments_dataset oopd 
left join olist_orders_dataset ood 
on oopd.order_id = ood.order_id
where ood.order_id is null;

#mengecek review ada tetapi tidak order
select COUNT(*)
from olist_order_reviews_dataset oord 
left join olist_orders_dataset ood 
on oord.order_id = ood.order_id
where ood.order_id is null;
