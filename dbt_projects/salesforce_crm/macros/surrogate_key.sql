{% macro surrogate_key(field_list) -%}
    {#
        Generates a surrogate key by hashing concatenated field values.
        
        Description: This macro creates a deterministic surrogate key from one or more 
        columns by concatenating their values with a delimiter and applying MD5 hashing.
        NULL values are replaced with a placeholder to ensure consistent hashing.
        
        Args:
            field_list: A list of column names to include in the surrogate key
            
        Returns:
            A SQL expression that generates an MD5 hash of the concatenated fields
            
        Example:
            {{ surrogate_key(['account_id', 'contact_id']) }}
    #}
    
    {%- set null_placeholder = '_dbt_surrogate_key_null_' -%}
    {%- set delimiter = '||' -%}
    
    md5(
        {%- for field in field_list %}
            coalesce(cast({{ field }} as {{ dbt.type_string() }}), '{{ null_placeholder }}')
            {%- if not loop.last %} || '{{ delimiter }}' || {% endif -%}
        {%- endfor %}
    )
{%- endmacro %}
