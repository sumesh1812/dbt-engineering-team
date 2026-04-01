{% macro safe_divide(numerator, denominator, default_value=0) -%}
    {#
        Performs division with protection against divide-by-zero errors.
        
        Description: This macro safely divides two values, returning a default value 
        when the denominator is zero or NULL. This prevents SQL errors and ensures 
        consistent handling of edge cases in calculations like win rates and averages.
        
        Args:
            numerator: The value to be divided (dividend)
            denominator: The value to divide by (divisor)
            default_value: The value to return when division is not possible (default 0)
            
        Returns:
            A SQL CASE expression that returns the division result or the default value
            
        Example:
            {{ safe_divide('closed_won_count', 'total_closed_count') }}
            {{ safe_divide('total_revenue', 'opportunity_count', none) }}
    #}
    
    case
        when {{ denominator }} is null then {{ default_value }}
        when {{ denominator }} = 0 then {{ default_value }}
        else {{ numerator }} / {{ denominator }}
    end
{%- endmacro %}
