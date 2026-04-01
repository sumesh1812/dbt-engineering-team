{% macro surrogate_key(field_list) -%}
    {#
        Description: Generates a surrogate key by hashing the concatenation of input fields.
        Handles null values by converting them to empty strings before concatenation.
        Uses MD5 hashing to produce a consistent 32-character hexadecimal string.
        
        Args:
            field_list: A list of column names to include in the surrogate key generation
            
        Returns:
            An MD5 hash string that serves as a surrogate key
            
        Example:
            {{ surrogate_key(['account_id', 'contact_id']) }}
    #}
    
    {%- set delimiter = '||' -%}
    
    md5(
        concat_ws(
            '{{ delimiter }}'
            {%- for field in field_list %}
            , coalesce(cast({{ field }} as {{ dbt.type_string() }}), '')
            {%- endfor %}
        )
    )
{%- endmacro %}
