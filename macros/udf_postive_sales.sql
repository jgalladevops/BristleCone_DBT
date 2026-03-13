{% macro udf_postive_sales() %}
 
CREATE OR REPLACE FUNCTION {{ target.schema }}.postive_sales(value NUMBER)
    RETURNS NUMBER
    LANGUAGE SQL
    AS 
    $$
        CASE 
            WHEN value < 0 THEN 0
            ELSE value 
        END 
    $$
    ;
 
{% endmacro %}