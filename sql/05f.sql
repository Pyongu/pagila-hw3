/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */
SELECT DISTINCT f.title
FROM film f
INNER JOIN film_category fc1 ON f.film_id = fc1.film_id
INNER JOIN film_category fc2 ON f.film_id = fc2.film_id
INNER JOIN category c1 ON fc1.category_id = c1.category_id
INNER JOIN category c2 ON fc2.category_id = c2.category_id
INNER JOIN film_actor fa1 ON f.film_id = fa1.film_id
INNER JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
INNER JOIN film f2 ON fa2.film_id = f2.film_id
WHERE f2.title = 'AMERICAN CIRCUS' AND c1.name != c2.name
AND c1.name IN (
    SELECT name
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)
AND c2.name IN (
    SELECT name
    FROM category
    JOIN film_category USING (category_id)
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)
ORDER BY f.title ASC;
