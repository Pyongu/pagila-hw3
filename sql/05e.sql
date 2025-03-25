/* 
 * You've decided that you don't actually like ACADEMY DINOSAUR and AGENT TRUMAN,
 * and want to focus on more movies that are similar to AMERICAN CIRCUS.
 * This time, however, you don't want to focus only on movies with similar actors.
 * You want to consider instead movies that have similar categories.
 *
 * Write a SQL query that lists all of the movies that share 2 categories with AMERICAN CIRCUS.
 * Order the results alphabetically.
 *
 * NOTE:
 * Recall that the following query lists the categories for the movie AMERICAN CIRCUS:
 * ```
 * SELECT name
 * FROM category
 * JOIN film_category USING (category_id)
 * JOIN film USING (film_id)
 * WHERE title = 'AMERICAN CIRCUS';
 * ```
 * This problem should be solved by a self join on the "film_category" table.
 */
SELECT DISTINCT f.title
FROM film f
INNER JOIN film_category fc1 ON f.film_id = fc1.film_id
INNER JOIN film_category fc2 ON f.film_id = fc2.film_id
INNER JOIN category c1 ON fc1.category_id = c1.category_id
INNER JOIN category c2 ON fc2.category_id = c2.category_id
WHERE c1.name != c2.name
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
