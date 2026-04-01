{% macro cents_to_dollars(column_name, decimal_places=2) -%}
    {#
        Description: Converts a monetary value from cents to dollars with specified precision.
        Useful when source systems store currency values as integers representing cents.
        
        Args:
            column_name: The column containing the value in cents
            decimal_places: Number of decimal places in the result (default: 2)
            
        Returns:
            The value converted to dollars with specified decimal precision
            
        Example:
            {{ cents_to_dollars('amount_cents') }}
    #}
    
    round({{ column_name }} / 100.0, {{ decimal_places }})
{%- endmacro %}
