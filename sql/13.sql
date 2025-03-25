/*
 * Management wants to create a "best sellers" list for each actor.
 *
 * Write a SQL query that:
 * For each actor, reports the three films that the actor starred in that have brought in the most revenue for the company.
 * (The revenue is the sum of all payments associated with that film.)
 *
 * HINT:
 * For correct output, you will have to rank the films for each actor.
 * My solution uses the `rank` window function.
 */
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    ranked_films.film_id,
    ranked_films.title,
    ranked_films.rank,
    ranked_films.revenue
FROM actor a
JOIN LATERAL (
    SELECT
        f.film_id,
        f.title,
        SUM(p.amount) AS revenue,
        RANK() OVER (PARTITION BY fa.actor_id ORDER BY SUM(p.amount) DESC, f.film_id ASC) AS rank  
    FROM film f
    JOIN film_actor fa ON fa.film_id = f.film_id
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r USING (inventory_id)
    JOIN payment p ON p.rental_id = r.rental_id
    WHERE fa.actor_id = a.actor_id
    GROUP BY f.film_id, f.title, fa.actor_id
) AS ranked_films ON TRUE 
WHERE ranked_films.rank <= 3
ORDER BY a.actor_id, ranked_films.rank;

