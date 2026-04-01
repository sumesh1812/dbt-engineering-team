{% macro generate_schema_name(custom_schema_name, node) -%}
    {#
        Generates the schema name for dbt models based on the custom_schema_name configuration.
        
        Description: This macro overrides the default dbt schema naming behavior to use 
        the custom_schema_name directly without prepending the target schema. This allows 
        bronze, silver, and gold layers to be deployed to their respective schemas.
        
        Args:
            custom_schema_name: The schema name configured in the model or dbt_project.yml
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
