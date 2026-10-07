select 
    id as payment_id,
    orderid as order_id,
    initcap(replace(paymentmethod,'_',' ')) as payment_method,
    initcap(status) as payment_status,
    amount as payment_amount,
    created as payment_created_date

from raw.stripe_payments
