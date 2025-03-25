/*
 * Management wants to rank customers by how much money they have spent in order to send coupons to the top 10%.
 *
 * Write a query that computes the total amount that each customer has spent.
 * Include a "percentile" column that contains the customer's percentile spending,
 * and include only customers in at least the 90th percentile.
 * Order the results alphabetically.
 *
 * HINT:
 * I used the `ntile` window function to compute the percentile.
 */
SELECT * FROM (
    SELECT 
        customer.customer_id,
        first_name || ' ' || last_name AS name,
        SUM(amount) AS total_payment,
        NTILE(100) OVER (ORDER BY SUM(amount) ASC) AS percentile
    FROM rental
    JOIN payment USING (rental_id)
    JOIN customer on payment.customer_id = customer.customer_id
    GROUP BY customer.customer_id
) ranked_customers
WHERE percentile >= 90
ORDER BY name ASC;
