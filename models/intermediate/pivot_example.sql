{{ config(
  enabled= false
) }}

{%-set payment_methods = ['Bank Transfer','Credit Card','Coupon','Gift Card'] -%}
{{payment_methods}}

{%- set payment_methods_snake_case = payment_methods | map('replace',' ','_') | list -%}
{{payment_methods_snake_case}}

 
with payments as (
   select * from {{ ref('stg_raw__stripe_payments') }}
),
 
final as (
   select
       order_id,
       {% for payment_method in payment_methods -%}
 
       sum(case when payment_method = '{{ payment_method }}' then payment_amount_usd else 0 end) 
            as {{ payment_methods_snake_case }}_amount
          
       {%- if not loop.last -%}
         ,
       {% endif -%}
 
       {%- endfor %}
   from payments
   group by 1
)
 
select * from final