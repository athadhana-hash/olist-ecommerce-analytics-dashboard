# mayoritas order berhasil delivered sehingga fulfillment secara umum berjalan baik.
select
order_status,
count(*) as total_order
from olist_orders_dataset ood
group by order_status
order by total_order desc;


# persentase delivered yang dominan menunjukkan tingkat penyelesaian transaksi sangat tinggi.
select
order_status,
round(
100.0 * count(*) /
sum(count(*)) over(),2
) as pct_orders
from olist_orders_dataset ood
group by order_status;


# cancellation rate yang rendah menunjukkan friksi operasional relatif kecil.
select
round(
100.0 *
sum(
case
when order_status='canceled'
then 1 else 0
end
)/count(*),2
) as cancellation_rate
from olist_orders_dataset ood;


# beberapa state memiliki cancel rate lebih tinggi yang dapat mengindikasikan masalah regional.
select
ocd.customer_state,

count(
case
when ood.order_status='canceled'
then 1
end
) as canceled_orders,

count(*) as total_orders,

round(
100.0 *
count(
case
when ood.order_status='canceled'
then 1
end
)/count(*),2
) as cancel_rate

from olist_orders_dataset ood
join olist_customers_dataset ocd
on ood.customer_id=ocd.customer_id

group by ocd.customer_state
order by cancel_rate desc;


# volume order menunjukkan pertumbuhan dengan lonjakan besar pada november 2017.
select
date_trunc(
'month',
ood.order_purchase_timestamp
) as month,

count(*) as total_order

from olist_orders_dataset ood

group by month
order by month;


# revenue meningkat sejalan dengan pertumbuhan order dan mencapai puncak pada november 2017.
select
date_trunc(
'month',
ood.order_purchase_timestamp
) as month,

sum(
ooid.price
) as revenue

from olist_orders_dataset ood

join olist_order_items_dataset ooid
on ood.order_id=ooid.order_id

group by month
order by month;


# delivery time membaik sepanjang waktu yang menunjukkan efisiensi operasional meningkat.
select
date_trunc(
'month',
ood.order_purchase_timestamp
) as month,

avg(
ood.order_delivered_customer_date
- ood.order_purchase_timestamp
) as avg_delivery_time

from olist_orders_dataset ood

where ood.order_status='delivered'

group by month
order by month;


# mayoritas customer hanya membeli satu kali sehingga retention tergolong rendah.
select
order_freq,
count(*) as total_customer

from(

select
ocd.customer_unique_id,

count(
distinct ood.order_id
) as order_freq

from olist_customers_dataset ocd

join olist_orders_dataset ood
on ocd.customer_id=ood.customer_id

group by ocd.customer_unique_id

)t

group by order_freq
order by order_freq;


# repeat customer memiliki spending lebih tinggi sehingga retention memiliki nilai bisnis besar.
with customer_orders as(

select
ocd.customer_unique_id,

count(
distinct ood.order_id
) as order_freq,

sum(
ooid.price
) as total_spent

from olist_customers_dataset ocd

join olist_orders_dataset ood
on ocd.customer_id=ood.customer_id

join olist_order_items_dataset ooid
on ood.order_id=ooid.order_id

group by ocd.customer_unique_id

)

select

case
when order_freq=1
then 'one-time'
else 'repeat'
end as customer_type,

count(*) as customers,

avg(
total_spent
) as avg_spent

from customer_orders

group by customer_type;


# review score tampaknya bukan faktor utama yang mendorong repeat purchase.
with customer_behavior as(

select
ocd.customer_unique_id,

count(
distinct ood.order_id
) as order_freq,

avg(
oord.review_score
) as avg_review_score

from olist_customers_dataset ocd

join olist_orders_dataset ood
on ocd.customer_id=ood.customer_id

join olist_order_reviews_dataset oord
on ood.order_id=oord.order_id

group by ocd.customer_unique_id

)

select

case
when order_freq=1
then 'one-time'
else 'repeat'
end as customer_type,

count(*) as customers,

round(
avg(avg_review_score),
2
) as avg_review

from customer_behavior

group by customer_type;


# keterlambatan pengiriman diuji memberikan dampak kepada review.
select

case
when ood.order_delivered_customer_date
<= ood.order_estimated_delivery_date

then 'on time'

else 'late'

end as delivery_status,

count(*) as orders,

round(
avg(oord.review_score),
2
) as avg_review_score

from olist_orders_dataset ood

join olist_order_reviews_dataset oord
on ood.order_id=oord.order_id

where ood.order_status='delivered'

group by delivery_status;


# berdasarkan analisis awal dapat dilihat customer dengan delivery telat lebih banyak melakukan repeat order.
with customer_orders as (

select
ocd.customer_unique_id,

max(
case
when ood.order_delivered_customer_date >
ood.order_estimated_delivery_date
then 1 else 0
end
) as ever_late,

count(
distinct ood.order_id
) as order_freq

from olist_customers_dataset ocd

join olist_orders_dataset ood
on ocd.customer_id=ood.customer_id

where ood.order_status='delivered'

group by ocd.customer_unique_id

)

select

case
when ever_late=1
then 'had late delivery'
else 'always on time'
end as delivery_experience,

round(
100.0 *
count(
case
when order_freq >1
then 1
end
)/count(*),2
) as repeat_rate

from customer_orders

group by delivery_experience;
