/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */
SELECT
    c.name,
    ranked_films.title,
    ranked_films.rental_count as "total rentals"
FROM category c
JOIN LATERAL (
    SELECT
        f.film_id,
        f.title,
        COUNT(r.rental_id) AS rental_count,
        RANK() OVER (PARTITION BY fc.category_id ORDER BY COUNT(r.rental_id) DESC, f.title DESC) AS rank  
    FROM film f
    JOIN film_category fc ON fc.film_id = f.film_id
    JOIN inventory i ON i.film_id = f.film_id
    JOIN rental r USING (inventory_id)
    WHERE fc.category_id = c.category_id
    GROUP BY f.film_id, f.title, fc.category_id
) AS ranked_films ON TRUE 
WHERE ranked_films.rank <= 5
ORDER BY c.name, ranked_films.rental_count DESC, ranked_films.title ASC;
