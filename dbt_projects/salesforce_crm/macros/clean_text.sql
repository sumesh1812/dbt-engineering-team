{% macro clean_text(column_name) -%}
    {#
        Cleans text values by trimming whitespace and converting empty strings to NULL.
        
        Description: This macro applies standard text cleaning rules CLN-001 and CLN-002 
        from the architecture document. It trims leading and trailing whitespace from 
        text fields and converts empty strings to NULL for consistent data handling.
        
        Args:
            column_name: The name of the text column to clean
            
        Returns:
            A SQL expression that returns cleaned text or NULL
            
        Example:
            {{ clean_text('account_name') }}
    #}
    
    nullif(trim({{ column_name }}), '')
{%- endmacro %}
