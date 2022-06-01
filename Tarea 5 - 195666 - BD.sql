 --Como parte de la modernizaci�n de nuestras video rental stores, vamos a automatizar la recepci�n y entrega de discos con robots.
--Parte de la infraestructura es dise�ar contenedores cil�ndricos giratorios para facilitar la colocaci�n y extracci�n de discos por brazos automatizados. Cada cajita de Blu-Ray mide 20cm x 13.5cm x 1.5cm, y para que el brazo pueda manipular adecuadamente cada cajita, debe estar contenida dentro de un arn�s que cambia las medidas a 30cm x 21cm x 8cm para un espacio total de 5040 cent�metros c�bicos y un peso de 500 gr por pel�cula.
--Se nos ha encargado formular la medida de dichos cilindros de manera tal que quepan todas las copias de los Blu-Rays de cada uno de nuestros stores. Las medidas deben ser est�ndar, es decir, la misma para todas nuestras stores, y en cada store pueden ser instalados m�s de 1 de estos cilindros. Cada cilindro aguanta un peso m�ximo de 50kg como m�ximo. El vol�men de un cilindro se calcula de [�sta forma.](volume of a cylinder)
--Esto no se resuelve con 1 solo query. El problema se debe partir en varios cachos y deben resolver cada uno con SQL.
--La informaci�n que no est� dada por el enunciado del problema o el contenido de la BD, podr� ser establecida como supuestos o assumptions, pero deben ser razonables para el problem domain que estamos tratando.


---NAIVE SOLUTION: 100 Peliculas en un cilindro con un hueco grande, i.e. sin circulos concentricos
	with movies_per_store as (select store_id, count(i.film_id) as pelis from inventory i group by store_id),
	ht as (select 1.5*100 as altura), --100 porque son 100 peliculas de 500 gramos, i.e. 50kg
	rad as (select sqrt(power(30/2,2) + power(21/2,2)) as radio)
	select mps.store_id, mps.pelis/100 as cilindros_por_tienda, (pi()*power(r.radio,2)*h.altura)/100 as volumen_de_cilindro from rad r, ht h, movies_per_store mps;