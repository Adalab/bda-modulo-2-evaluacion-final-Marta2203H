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

-- 