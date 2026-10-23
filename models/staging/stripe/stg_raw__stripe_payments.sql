with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

transformed as (

select 
    id as payment_id,
    orderid as order_id,
    initcap(replace(paymentmethod,'_',' ')) as payment_method,
    initcap(status) as payment_status,
    {{ cents_to_dollars('amount') }} as payment_amount_usd, --uses cents_to_dollars macro to convert from cents to dollars
    created as payment_created_date

from source

)

select * from transformed