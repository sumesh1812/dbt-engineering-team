{% macro safe_divide(numerator, denominator, default_value=0) -%}
    {#
        Description: Performs division with protection against divide-by-zero errors.
        Returns a default value when the denominator is zero or null.
        
        Args:
            numerator: The value to be divided (dividend)
            denominator: The value to divide by (divisor)
            default_value: The value to return if division is not possible (default: 0)
            
        Returns:
            The result of the division or the default value if denominator is zero or null
            
        Example:
            {{ safe_divide('total_revenue', 'total_opportunities') }}
            {{ safe_divide('won_amount', 'total_amount', default_value='null') }}
    #}
    
    case
        when {{ denominator }} is null then {{ default_value }}
        when {{ denominator }} = 0 then {{ default_value }}
        else {{ numerator }} / {{ denominator }}
    end
{%- endmacro %}
