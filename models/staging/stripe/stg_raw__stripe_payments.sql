with 

source as (

    select * from {{ source('stripe', 'payments') }}

),

renamed as (

select 
    id as payment_id,
    orderid as order_id,
    initcap(replace(paymentmethod,'_',' ')) as payment_method,
    initcap(status) as payment_status,
    amount/100 as payment_amount_usd,
    created as payment_created_date

from source

)

select * from renamed