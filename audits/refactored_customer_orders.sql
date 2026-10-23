-------------------------------------------
-- Compare Row Counts
-------------------------------------------
{% set old_relation = adapter.get_relation(
      database = "dbt_jaffle_shop",
      schema = "dbt_kwilliams",
      identifier = "customer_orders_legacy"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{{ audit_helper.compare_row_counts(
    a_relation = old_relation,
    b_relation = dbt_relation
) }}

-- Legacy = 99 records
-- Refactored = 99 records

-------------------------------------------
-- Compare Column Values
-------------------------------------------
{% set old_relation = adapter.get_relation(
      database = "dbt_jaffle_shop",
      schema = "dbt_kwilliams",
      identifier = "customer_orders_legacy"
) -%}

{% set dbt_relation = ref('fct_customer_orders') %}

{% if execute %} -- this if block ensures the audit is run after executing, not just using metadata gained from parsing.

{{ audit_helper.compare_all_columns(
    a_relation = old_relation,
    b_relation = dbt_relation
) }}

{% endif %}