{{
    config(
        severity='warn'
    )
}}

select 
        customer_id,
        count(*) as id_count
from    {{ ref('dim_customers') }}
group by customer_id
having id_count > 1