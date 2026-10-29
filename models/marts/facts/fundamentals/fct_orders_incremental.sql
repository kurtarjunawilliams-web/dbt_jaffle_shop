
{{
  config(
    materialized = 'incremental',
    unique_key = 'order_id',
    incremental_strategy = 'merge',
    enabled= false
) }}

  )
}}

--Import CTEs
with orders as  (
    select * from {{ ref ('stg_raw__jaffle_shop_orders' )}}
),

payments as (
    select * from {{ ref ('stg_raw__stripe_payments') }}
),

-- Logical CTEs
order_payments as (
    select
        order_id,
        sum (case when payment_status = 'success' then payment_amount_usd end) as amount

    from payments
    group by 1
),


{% if is_incremental() %}
-- Calculate the max date first in a separate Databricks-friendly pass
max_date as (
    select max(order_date) as max_val from {{ this }}
),
{% endif %}

--Final CTE
 final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce (order_payments.amount, 0) as amount

    from orders
    left join order_payments using (order_id)
)

select * from final


{% if is_incremental() %}
where
order_date >= max_date
{% endif %}
