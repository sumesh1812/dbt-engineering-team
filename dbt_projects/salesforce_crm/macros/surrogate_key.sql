{% macro surrogate_key(field_list) %}
    {#
        Description: Generates a surrogate key by hashing the concatenation of multiple fields.
        This macro creates a deterministic, unique identifier from one or more source columns.
        Null values are handled by coalescing to a placeholder string to ensure consistent hashing.
        
        Args:
            field_list: A list of column names to include in the surrogate key generation
        
        Returns:
            A MD5 hash string representing the surrogate key
        
        Example Usage:
            {{ surrogate_key(['account_id', 'contact_id']) }}
            {{ surrogate_key(['opportunity_id']) }}
    #}
    
    {%- set null_placeholder = '_dbt_null_surrogate_key_' -%}
    
    {%- set fields = [] -%}
    
    {%- for field in field_list -%}
        {%- set _ = fields.append(
            "coalesce(cast(" ~ field ~ " as " ~ dbt.type_string() ~ "), '" ~ null_placeholder ~ "')"
        ) -%}
    {%- endfor -%}
    
    {{ dbt.hash(dbt.concat(fields)) }}
    
{% endmacro %}
