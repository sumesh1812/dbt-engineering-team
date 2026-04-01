{% macro generate_schema_name(custom_schema_name, node) -%}
    {#
        Description: Custom schema name generation macro for the salesforce_crm project.
        This macro controls how dbt generates schema names in the target database.
        
        Behavior:
        - In production (target.name == 'prod'), uses the custom_schema_name directly
          to create clean schema names like 'bronze', 'silver', 'gold'
        - In non-production environments, prefixes the custom_schema_name with the
          target schema to create isolated development/test schemas
        
        Parameters:
        - custom_schema_name: The schema name specified in model config (+schema)
        - node: The dbt node object containing model metadata
        
        Returns:
        - String: The fully qualified schema name to use for the model
    #}
    
    {%- set default_schema = target.schema -%}
    
    {%- if custom_schema_name is none -%}
        {# No custom schema specified, use the default target schema #}
        {{ default_schema }}
    
    {%- elif target.name == 'prod' -%}
        {# Production environment: use clean schema names without prefix #}
        {{ custom_schema_name | trim }}
    
    {%- else -%}
        {# Non-production: prefix with target schema for isolation #}
        {{ default_schema }}_{{ custom_schema_name | trim }}
    
    {%- endif -%}

{%- endmacro %}
