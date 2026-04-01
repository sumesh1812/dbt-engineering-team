{% macro cents_to_dollars(column_name, precision=2) %}
    {#
        Description: Converts monetary values stored in cents to dollars.
        This macro handles the common pattern where financial systems store
        currency amounts as integers in cents for precision purposes.
        
        Args:
            column_name: The column containing the value in cents
            precision: Number of decimal places for rounding (default: 2)
        
        Returns:
            The monetary value expressed in dollars with specified precision
        
        Example Usage:
            {{ cents_to_dollars('amount_cents') }}
            {{ cents_to_dollars('transaction_amount', 4) }}
    #}
    
    round(cast({{ column_name }} as decimal(18, 4)) / 100, {{ precision }})
    
{% endmacro %}
