{% macro surrogate_key(field_list) %}
    {#
        Description: Generates a surrogate key by hashing the concatenation of input fields.
        This macro creates a deterministic, unique identifier from one or more columns
        that can be used as a primary key for dimensional models.
        
        Features:
        - Handles NULL values by coalescing to empty string
        - Uses MD5 hashing for consistent key generation
        - Separates fields with delimiter to avoid collision
        - Casts all inputs to string for consistent hashing
        
        Parameters:
        - field_list: A list of column names to include in the surrogate key
        
        Returns:
        - String: MD5 hash of the concatenated field values
        
        Usage:
        {{ surrogate_key(['account_id', 'contact_id']) }} as unique_key
        
        Example Output:
        MD5('abc123||def456') -> '5d41402abc4b2a76b9719d911017c592'
    #}
    
    {%- set delimiter = '||' -%}
    
    {%- set field_concat = [] -%}
    
    {%- for field in field_list -%}
        {%- set _ = field_concat.append(
            "coalesce(cast(" ~ field ~ " as " ~ dbt.type_string() ~ "), '')"
        ) -%}
    {%- endfor -%}
    
    {{ dbt.hash(field_concat | join(" || '" ~ delimiter ~ "' || ")) }}

{% endmacro %}
