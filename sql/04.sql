/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but have never appeared in any movie in the "Horror" category.
 */
SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor.actor_id
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
    WHERE category.name = 'Children'
    GROUP BY actor.actor_id
) AND actor_id NOT IN (
    SELECT actor.actor_id
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    JOIN film_actor USING (film_id)
    JOIN actor USING (actor_id)
    WHERE category.name = 'Horror'
    GROUP BY actor.actor_id
)
GROUP BY first_name, last_name
ORDER BY last_name;
