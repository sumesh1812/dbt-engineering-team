{% macro safe_divide(numerator, denominator, default_value=0) %}
    {#
        Description: Performs division while safely handling division by zero scenarios.
        This macro returns a default value when the denominator is zero or null,
        preventing runtime errors and ensuring consistent analytical results.
        
        Args:
            numerator: The dividend expression or column name
            denominator: The divisor expression or column name
            default_value: The value to return when division is not possible (default: 0)
        
        Returns:
            The result of the division, or the default_value if denominator is zero or null
        
        Example Usage:
            {{ safe_divide('total_won', 'total_opportunities') }}
            {{ safe_divide('revenue', 'units_sold', none) }}
            {{ safe_divide('closed_won_count', 'closed_won_count + closed_lost_count', 0) }}
    #}
    
    case
        when {{ denominator }} is null then {{ default_value }}
        when {{ denominator }} = 0 then {{ default_value }}
        else {{ numerator }} / nullif({{ denominator }}, 0)
    end
    
{% endmacro %}
