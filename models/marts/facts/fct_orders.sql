select      jso.order_id,
            jso.customer_id,
            sum(payment_amount) as payment_amount

from        dbt_kwilliams.stg_jaffle_shop__orders jso
left join   dbt_kwilliams.stg_stripe__payments sp
    on      jso.order_id = sp.order_id

group by    jso.order_id,jso.customer_id