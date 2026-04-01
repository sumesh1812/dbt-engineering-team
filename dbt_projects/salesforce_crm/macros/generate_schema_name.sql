{% macro generate_schema_name(custom_schema_name, node) -%}
    {#
        Description: Custom schema name generation macro that uses the custom schema name directly
        without prefixing with the target schema. This allows medallion layers (bronze, silver, gold)
        to be created as separate schemas in the target database.
        
        Args:
            custom_schema_name: The schema name specified in model config (+schema)
            node: The dbt node object containing model metadata
            
        Returns:
            The schema name to use for the model
    #}
    
    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
