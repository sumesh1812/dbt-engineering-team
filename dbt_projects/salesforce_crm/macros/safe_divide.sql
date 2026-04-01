{% macro safe_divide(numerator, denominator, default_value=0) %}
    {#
        Description: Performs division with protection against divide-by-zero errors.
        Returns a default value when the denominator is zero or NULL, preventing
        runtime errors in SQL calculations.
        
        Features:
        - Handles NULL denominators gracefully
        - Handles zero denominators gracefully
        - Returns configurable default value on error conditions
        - Casts result to float for consistent decimal handling
        
        Parameters:
        - numerator: The dividend value (top of the fraction)
        - denominator: The divisor value (bottom of the fraction)
        - default_value: Value to return when division is not possible (default: 0)
        
        Returns:
        - Numeric: Result of division or default_value if denominator is zero/NULL
        
        Usage Examples:
        {{ safe_divide('total_won', 'total_closed') }} as win_rate
        {{ safe_divide('revenue', 'units_sold', none) }} as price_per_unit
        {{ safe_divide('sum_amount', 'count_deals', 0) }} as avg_deal_size
        
        SQL Output:
        CASE 
            WHEN denominator IS NULL OR denominator = 0 
            THEN default_value 
            ELSE numerator / denominator 
        END
    #}
    
    case
        when {{ denominator }} is null or {{ denominator }} = 0
        then {{ default_value }}
        else cast({{ numerator }} as {{ dbt.type_float() }}) / cast({{ denominator }} as {{ dbt.type_float() }})
    end

{% endmacro %}
