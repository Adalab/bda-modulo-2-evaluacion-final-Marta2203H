USE sakila;

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
-- Uso DISTINCT para que no aparezcan los títulos duplicados.*/

SELECT DISTINCT title 
	FROM film;

/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13". 
-- Usamos WHERE para filtrar las peliculas por PG-13*/

SELECT title
	FROM film
    WHERE rating = "PG-13"; 
    
/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
-- Usamos LIKE para filtrar */

SELECT title , description
	FROM film
	WHERE description LIKE '%amazing%'; 

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
    
/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. 
-- Uso BETWEEN para seleccionar los valores que se encuentran entre un rango determinado*/

SELECT first_name, last_name
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;

/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
-- NOT IN lo uso para excluir las películas que sean sean ni "R" ni "PG-13" */

SELECT title
	FROM film
    WHERE rating NOT IN ('R', 'PG-13'); 

/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con
el recuento.
-- Uso COUNT para contar las películas en cada grupo
-- Agrupo con GROUP BY*/

SELECT COUNT(film_id) AS total_films, rating 
	FROM film
    GROUP BY rating;  

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y 
muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
-- Uso INNER JOIN para obtener solo los registros que tienen coincidencias en las tablas (rental y customer)
-- Uso USING, ya que customer_id aparece en las dos tablas igual, por lo contrario usaria ON*/ 

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS rented_film 
	FROM customer AS c
	INNER JOIN rental AS r     
		USING (customer_id) 	
	GROUP BY c.customer_id, c.first_name, c.last_name;

/* 11. Encuentra la cantidad total de películas alquiladas por categoría y 
muestra el nombre de la categoría junto con el
recuento de alquileres.
-- Uso INNER JOIN para relaccionar las tablas category, film_category, inventory y rental y nos devolvera las filas donde coincidan
*/ 

SELECT COUNT(r.rental_id) AS rented_film, c.name AS category_name
	FROM category AS c 
		INNER JOIN film_category AS fc  
			USING(category_id)
		INNER JOIN inventory AS i 
			USING(film_id)
		INNER JOIN rental AS r 
			USING(inventory_id)
GROUP BY category_name;

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y 
muestra la clasificación junto con el promedio de duración.
-- Uso AVG para realizar la media de la duración de todas las películas, lo redondeo con ROUND a dos decimales
-- Con GROUP BY agrupo agrupo por categoría.*/

SELECT rating, ROUND(AVG(length),2) AS avg_length 
	FROM film
GROUP BY rating;  

/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". 
- Uso INNER JOIN entre las tablas actor, film_actor y film y nos devuelve las filas en las que coincidan
-- Uso USING ya que la columna común se llama igual en las tablas que unimos.
-- Uso WHERE para filtrar por película.*/

SELECT first_name, last_name, title
	FROM Actor
		INNER JOIN film_actor 
			USING (actor_id)
		INNER JOIN film AS f
			USING (film_id)
	WHERE f.title = 'Indian Love';

/*14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción
-- Uso LIKE para buscar en que películas aparecen las palabras "cat" y "dog"*/

SELECT title, description
	FROM film
    WHERE description LIKE "%dog%" OR description LIKE'%cat%';

/* 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. 
-- Uso LEFT JOIN para asegurarnos de que obtengamos todos los actores, incluso si no están en la tabla film_actor. 
 -- Uso WHERE para seleccionar a los actores que no aparecen en ninguna película 
 -- Como me sale una tabla vacía hago comprobación contando el total de actores en la tabla actor*/

SELECT a.actor_id, a.first_name, a.last_name
	FROM actor AS a
LEFT JOIN film_actor AS fa
	USING (actor_id)
WHERE fa.actor_id IS NULL;

-- Comprobación 

SELECT COUNT(*) AS total_actors
FROM actor;

/* 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010 
-- Uso BETWEEN para seleccionar los valores que se encuentran entre un rango determinado**/

SELECT title, release_year 
	FROM film AS f 
	WHERE release_year BETWEEN 2005 AND 2010;

/* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family". 
-- Uso dos INNER JOINS para que me devuelva los datos que coinciden en las tablas
-- Uso USING ya que el nombre de las columnas es igual en las tablas del JOIN
-- WHERE filtra las filas donde el nombre de la categoria es "Family"*/

SELECT f.title, c.name AS category_name
FROM film AS f
    INNER JOIN film_category AS fc
		USING (film_id)
    INNER JOIN category AS c
		USING (category_id)
WHERE c.name = 'Family';

/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
-- INNER JOIN para que me devuelva los datos de actor_id que coinciden
-- USING por que el nombre coincide
-- GROUP BY agrupo por first_name y last_name
-- HAVING contamos las peliculas por cada actor e incluimos solo los actores que hayan actuado en más de 10 películas*/

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_films
	FROM actor AS a
	INNER JOIN film_actor AS fa
		USING (actor_id)
GROUP BY a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10;

/* 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
-- WHERE para filtrar las películas que son "R" y tienen una duración mayor a 2 horas*/

SELECT title, length
FROM film 
WHERE rating = 'R' AND `length` > 120;

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
nombre de la categoría junto con el promedio de duración.
Uso JOING para unir las tablas y que me devuelva las coincidencias entre ellas de flim_id y category_id
GROUP BY para agrupar por name (categoria)
HAVING coge solo las categorias cuya media (Calculamos con AVG) sea mayor a 120 min*/

SELECT c.name AS category_name, ROUND(AVG(f.length),2) AS avg_length
	FROM film AS f
	INNER JOIN film_category AS fc
		USING (film_id)
	INNER JOIN category AS c
		USING (category_id)
GROUP BY c.name 
HAVING AVG(f.length) > 120;

/* Encuentra los actores que han actuado en al menos 5 películas y 
muestra el nombre del actor junto con la cantidad de películas en las que han actuado.

-- INNER JOIN coge los artistas de las dos tablas que coinciden, es decir que han actuado en alguna película
GROUP BY agrupo por nombre y apellidos de la tabla actor
HAVING  filtra los resultados para incluir solos los que han participado al menos en 5 películas*/

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS total_films
	FROM actor AS a
	INNER JOIN film_actor AS fa
		USING (actor_id) 
GROUP BY a.first_name, a.last_name
HAVING COUNT(fa.film_id) >= 5;

/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y 
luego selecciona las películas correspondientes.
-- Lo primero que he hecho es una query sencilla para ver que peliculas has sido alquiladas por más de 5 días restando "return_date - rental_date"
-- DISTINCT para que los titulos no se repitan
-- Seleccion todos los "film_id" de la tabla film y hago una subconsulta para que me diga cuales de todas las peliculas has sido alquiladas por más de 5 días*/

SELECT rental_id
	FROM rental AS r 
	WHERE DAY(return_date) - DAY(rental_date) > 5;
    
SELECT DISTINCT f.title
	FROM film AS f 
WHERE f.film_id IN (SELECT rental_id
						FROM rental AS r 
						WHERE DAY(return_date) - DAY(rental_date) > 5);

/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
exclúyelos de la lista de actores.
-- Primero con una query secilla busco los actures que han actuado en una alguna pelicula de Horror, usando el INNER JOIN para coger los valores que tienen en común y uso WHERE para filtrar por nombre de categoría "Horror"
 -- En la query princial seleciono el nombre y apellido de la tabla actor 
 IS NOT antes de añadir la subconsulta por que lo que me interesa saber son los actures que no han actuado en ninguna película de "Horror" y le añado la subconsulta*/

SELECT fa.actor_id
    FROM film_actor AS fa
    INNER JOIN film_category AS fc
		USING(film_id)
    INNER JOIN category AS c
		USING (category_id)
	WHERE c.name = 'Horror';

SELECT a.first_name, a.last_name
	FROM actor AS a
	WHERE a.actor_id NOT IN (SELECT fa.actor_id
									FROM film_actor AS fa
										INNER JOIN film_category AS fc
											USING(film_id)
										INNER JOIN category AS c
											USING (category_id)
									WHERE c.name = 'Horror');

/* 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
tabla film.
-- INNER JOIN unir las tablas y que nos devuelva los datos que coinciden en las tablas
-- WHERE en la tabla category buscamos la categoria "comedy" y en la tabla film buscamos las que tengan una duración mayor a 180 minutos*/

SELECT title
	FROM film AS f
		INNER JOIN film_category AS fc
			USING (film_id )
		INNER JOIN category AS c
			USING (category_id)
WHERE c.name = 'Comedy' AND f.length >180 ; 