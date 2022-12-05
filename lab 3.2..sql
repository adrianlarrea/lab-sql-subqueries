USE sakila;

-- 1.How many copies of the film Hunchback Impossible exist in the inventory system?
select * from inventory;
select * from film;


SELECT count(i.store_id), f.title
FROM film f
JOIN inventory i USING(film_id)
WHERE f.title = 'Hunchback Impossible' 
;

-- 2.List all films whose length is longer than the average of all the films.
select * from film;

 
SELECT title FROM film
WHERE length > (
  SELECT avg(length)
  FROM film
);

-- 3.Use subqueries to display all actors who appear in the film Alone Trip.
select * from film;
select * from actor;
select * from film_actor;


SELECT first_name, last_name FROM actor 
WHERE actor_id IN (
SELECT actor_id FROM film_actor
WHERE film_id IN (
SELECT film_id
FROM film 
WHERE title = 'Alone Trip')
);



-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion.
-- Identify all movies categorized as family films
select * from film;
select * from film_category;

select title from film
where film_id IN (
select film_id from film_category
where category_id IN (
select category_id from category
WHERE name = 'Family')
);




-- 5.Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.
select * from country;
select * from city;
select * from address;
select * from customer;


select first_name, email from customer
where address_id IN (
select address_id from address
where city_id in (
select city_id from city
where country_id in (
select country_id from country
WHERE country = 'Canada')));





-- 6.Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select * from film;
select * from actor;
select * from film_actor;

SELECT film_id FROM film_actor WHERE actor_id IN (
		SELECT actor_id
		FROM film_actor
		GROUP BY actor_id
		ORDER BY COUNT(actor_id) DESC
		LIMIT 1);




-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
-- MAX sum of customer

select * from customer;
select * from payment;


SELECT DISTINCT(title)
FROM sakila.film
WHERE film_id IN (SELECT film_id
FROM sakila.inventory
WHERE inventory_id IN (SELECT inventory_id
FROM sakila.rental
WHERE customer_id = (SELECT customer_id
FROM sakila.payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1)));



-- 8. Customers who spent more than the average payments.
-- average payment a customer has made


SELECT customer_id, first_name, last_name
FROM sakila.customer
WHERE customer_id IN (SELECT customer_id
FROM sakila.payment
GROUP BY customer_id
HAVING SUM(amount)> (SELECT SUM(total_per_client)/COUNT(customer_id)
FROM (SELECT customer_id, SUM(amount) AS total_per_client
FROM sakila.payment
GROUP BY customer_id) sub2));





