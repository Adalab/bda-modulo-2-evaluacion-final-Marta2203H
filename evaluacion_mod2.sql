USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title -- Uso DISTINCT para que no aparezcan los títulos duplicados.
	FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title
	FROM film
    WHERE rating = "PG-13"; -- Usamos WHERE para filtrar las peliculas por PG-13
    
-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title , description
	FROM film
	WHERE description LIKE '%amazing%'; -- Usamos LIKE para filtrar

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title
	FROM film
    WHERE length > 120; 

-- 5. Recupera los nombres de todos los actores.

SELECT first_name, last_name
	FROM actor;
    
-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name, last_name
	FROM actor
	WHERE last_name = 'Gibson';
    
-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name, last_name
	FROM actor
    WHERE actor_id >= 10 AND actor_id <= 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT title
	FROM film
    WHERE rating NOT IN ('R', 'PG-13'); -- NOT IN lo uso para excluir las películas que sean sean ni "R" ni "PG-13"

/*-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con
el recuento.*/

SELECT COUNT(film_id) AS total_films, rating -- Uso COUNT para contar las películas en cada grupo
	FROM film
    GROUP BY rating;  -- Agrupo con GROUP BY

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
apellido junto con la cantidad de películas alquiladas.*/ 

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rented_film 
	FROM customer AS c
	INNER JOIN rental AS r     -- INNER JOIN para juntar dos tablas en este caso customer y rental y nos devuelve lo común en ambas.
	USING (customer_id) 	   -- USO USING, ya que customer_id aparece en las dos tablas igual, por lo contrario usaria ON
	GROUP BY c.customer_id, c.first_name, c.last_name;

