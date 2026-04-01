{% macro generate_schema_name(custom_schema_name, node) -%}
    {#
        Description: Custom schema name generation macro for the salesforce_crm dbt project.
        This macro controls how schema names are generated based on the target environment.
        
        In production (target.name == 'prod'), schemas are named exactly as specified in the model config.
        In development environments, schemas are prefixed with the target schema to allow developer isolation.
        
        Args:
            custom_schema_name: The schema name specified in the model's +schema config
            node: The dbt node object containing model metadata
        
        Returns:
            The fully qualified schema name to use for the model
    #}
    
    {%- set default_schema = target.schema -%}
    
    {%- if custom_schema_name is none -%}
        {# No custom schema specified, use the target schema #}
        {{ default_schema }}
    
    {%- elif target.name == 'prod' -%}
        {# Production environment uses the custom schema name directly #}
        {{ custom_schema_name | trim }}
    
    {%- else -%}
        {# Development environments prefix custom schema with target schema for isolation #}
        {{ default_schema }}_{{ custom_schema_name | trim }}
    
    {%- endif -%}

{%- endmacro %}
