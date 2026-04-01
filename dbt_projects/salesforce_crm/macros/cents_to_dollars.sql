{% macro cents_to_dollars(amount_in_cents) %}
    {#
        Description: Converts monetary amounts from cents to dollars.
        Useful when source systems store currency values as integers
        representing cents to avoid floating point precision issues.
        
        Parameters:
        - amount_in_cents: The monetary value expressed in cents
        
        Returns:
        - Numeric: The monetary value converted to dollars with 2 decimal places
        
        Usage:
        {{ cents_to_dollars('amount_cents') }} as amount_dollars
    #}
    
    round(cast({{ amount_in_cents }} as {{ dbt.type_float() }}) / 100.0, 2)

{% endmacro %}
