/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN film_actor fa1 ON a.actor_id = fa1.actor_id
JOIN film f1 ON fa1.film_id = f1.film_id
JOIN film_actor fa2 ON f1.film_id = fa2.film_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE a2.actor_id IN (
    SELECT fa.actor_id
    FROM film_actor fa
    JOIN film f ON fa.film_id = f.film_id
    WHERE f.title IN (
        SELECT title
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        WHERE fa.actor_id = 112
    )
)
AND a.actor_id != 112

EXCEPT

SELECT first_name || ' ' || last_name AS "Actor Name"
FROM film
JOIN film_actor USING (film_id)
JOIN actor USING (actor_id)
WHERE film_id IN (
    SELECT film_id
    FROM film
    JOIN film_actor USING (film_id)
    WHERE actor_id = 112
    GROUP BY film_id
) AND actor_id != 101
GROUP BY first_name, last_name

ORDER BY "Actor Name" ASC;
