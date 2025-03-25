/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN LATERAL (
  SELECT name
  FROM rental r
  JOIN inventory USING (inventory_id)
  JOIN film USING (film_id)
  JOIN film_category on film.film_id = film_category.film_id
  JOIN category USING (category_id)
  WHERE r.customer_id = c.customer_id
  GROUP BY name, rental_date
  ORDER BY rental_date DESC
  LIMIT 5
) r on TRUE
WHERE r.name = 'Action'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING count(*) >= 3
ORDER BY customer_id ASC;
