select
    order_id,
    sum(payment_amount_usd) as total_payment_amount
from {{ref('stg_raw__stripe_payments')}}
group by 1
having sum(payment_amount_usd)<0