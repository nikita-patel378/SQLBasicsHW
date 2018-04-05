/*1a*/
SELECT first_name, last_name FROM actor;

/*1b*/
SELECT concat(first_name, ' ', last_name) AS Actor_Name FROM actor

/*2a*/
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "Joe";

/*2b*/
SELECT * FROM actor WHERE last_name LIKE '%gen%';

/*2c*/
SELECT * FROM actor WHERE last_name LIKE "%li%"
ORDER BY last_name,first_name;

/*2d*/
SELECT country_id,country 
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

/*3a*/
ALTER TABLE `sakila`.`actor` 
ADD COLUMN `middle_name` VARCHAR(45) NOT NULL AFTER `first_name`;

/*3b*/
ALTER TABLE `sakila`.`actor` 
CHANGE COLUMN `middle_name` `middle_name` BLOB NOT NULL ;

/*3c*/
ALTER TABLE actor DROP middle_name;

/*4a*/
SELECT COUNT(last_name), last_name FROM actor 
GROUP BY last_name;

/*4b*/
SELECT last_name, COUNT(last_name) as c FROM actor
GROUP BY last_name
HAVING c >=2;

/*4c*/
UPDATE actor SET first_name = "HARPO" WHERE
first_name = "GROUCHO" and last_name = "WILLIAMS";
SELECT * FROM actor WHERE actor_id = 172;

/*4d*/
UPDATE actor SET first_name = "GROUCHO"
WHERE first_name = "HARPO" and last_name = "WILLIAMS";

/*5a*/
SHOW CREATE TABLE address;

/*6a*/
SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address
ON staff.address_id=address.address_id;

/*6b*/
SELECT staff.first_name, staff.last_name, payment.payment_date, SUM(amount)
FROM staff
JOIN payment
ON staff.staff_id=payment.staff_id
WHERE payment_date LIKE "%2005-08%"
GROUP BY first_name;

/*6c*/
SELECT film.title, COUNT(film_actor.actor_id)
FROM film_actor
JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film.title;

/*6d*/
SELECT film.title, COUNT(inventory.inventory_id) AS Copies
FROM film
JOIN inventory
ON film.film_id = inventory.film_id
WHERE title= "Hunchback Impossible"
GROUP BY title;

/*6e*/
SELECT SUM(payment.amount) as TotalSum, customer.first_name, customer.last_name
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY first_name,last_name
ORDER By last_name;

/*7a*/
SELECT title
FROM film
WHERE language_id IN
(SELECT language_id
FROM language
WHERE name="English"
)
AND title LIKE 'K%'
OR title LIKE 'Q%' 
;

/*7b*/
SELECT first_name,last_name
FROM actor
WHERE actor_id IN
(SELECT actor_id
FROM film_actor
WHERE film_id IN
(SELECT film_id
FROM film
WHERE title = "Alone Trip"
)
);

/*7c*/
SELECT customer.first_name, customer.last_name,customer.email
FROM country
JOIN city
ON country.country_id = city.country_id
JOIN address
ON city.city_id = address.city_id
JOIN customer
ON customer.address_id = address.address_id
WHERE country = "Canada";

/*7d*/
SELECT * FROM film_list
WHERE category = "Family";

/*7e*/
SELECT  COUNT(*) AS Rentals, film.title
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
JOIN rental
ON payment.rental_id=rental.rental_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON inventory.film_id = film.film_id
GROUP BY film.title
ORDER BY Rentals DESC
LIMIT 5;

/*7f*/
SELECT store.store_id,SUM(amount) AS Gross
FROM payment 
JOIN rental
ON payment.rental_id = rental.rental_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN store
ON inventory.store_id = store.store_id
GROUP BY store.store_id;

/*7g*/
SELECT store.store_id, city.city, country.country
FROM country
JOIN city
ON country.country_id=city.country_id
JOIN address
ON city.city_id=address.city_id
JOIN store
ON address.address_id=store.address_id;

/*7h*/
SELECT category.name, SUM(payment.amount) as Gross
FROM payment
JOIN rental
ON payment.rental_id = rental.rental_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film_category
ON inventory.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY Gross DESC
Limit 5;

/*8a*/
CREATE VIEW topfivegross AS
SELECT category.name, SUM(payment.amount) as Gross
FROM payment
JOIN rental
ON payment.rental_id = rental.rental_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film_category
ON inventory.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY Gross DESC
Limit 5;

/*8b*/
SELECT * FROM sakila.topfivegross;

/*8c*/
DROP VIEW topfivegross;

