{% test assert_unique_active_records(model, column_name) %}

select
    {{column_name}} as unique_field,
    count(*) as n_records
from {{model}}
where {{column_name}} is not null and valid_to is null
group by {{column_name}}
having count(*) > 1

{% endtest %}