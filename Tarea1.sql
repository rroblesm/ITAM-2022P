--			EJERCICIOS DE TAREA MORAL			--
--�Qu� contactos de proveedores tiene la posici�n de sales representative?
select s.contact_name from suppliers s where s.contact_title = 'Sales Representative';

--�Qu� contactos de proveedores no son marketing managers?
select s.contact_name from suppliers s where s.contact_title != 'Marketing Manager';

--select * from suppliers s;

--�cu�les ordenes no vienen de clientes de Estados Unidos?* con join
select o.order_id from orders o, customers c
where c.country != 'USA';

--�Qu� productos de los que transportamos son quesos?
--select * from categories c ; primero buscar el id de la categor�a quesos
select p.product_name  from products p where p.category_id = 4;

--�Qu� ordenes van a B�lgica o Francia?
select o.order_id from orders o 
where (o.ship_country = 'France' or o.ship_country = 'Belgium' ) and  shipped_date is null ;

--�Qu� ordenes van a LATAM?
select order_id from orders o 
where (o.ship_country = 'Mexico' or o.ship_country = 'Argentina' or o.ship_country = 'Venezuela' or o.ship_country = 'Brazil') 
and  shipped_date is null;

--�Qu� ordenes NO van a LATAM?
select order_id from orders o 
where (o.ship_country != 'Mexico' and  o.ship_country != 'Argentina' and o.ship_country != 'Venezuela' and o.ship_country != 'Brazil') 
and shipped_date is null;

--Necesitamos los nombre completos de los empleados, nombres y apellidos unidos en un mismo registro***
select concat(e.first_name, ' ', e.last_name) from employees e;

--�Cu�nta lana tenemos en el inventario?
select sum(p.unit_price*p.units_in_stock) from products p where p.units_in_stock != 0;

--�C�antos clientes tenemos de cada pa�s?
select c.country, count(c.contact_name)  from customers c group by c.country;


---Obtener un reporte de edades de los empleados para checar su elegibilidad para seguro de gastos m�dicos menores.
select concat(e.first_name,' ',e.last_name), (current_date - e.birth_date)/365 as edad from employees e;

--- Cu�l es la orden m�s reciente por cliente?
---Como order id es un numero entero consecutivo que aumenta en cada nueva orden, esta relacionado con order date
SELECT o.customer_id, MAX(o.order_id), max(order_date)
FROM orders o 
group by o.customer_id 

----De nuestros clientes, qu� funci�n desempe�an y cu�ntos son?
select c.contact_title, count(c.customer_id) from customers c group by c.contact_title;

---Cu�ntos productos tenemos de cada categor�a?
select p.category_id, count(p.product_id) from products p group by p.category_id ;

---C�mo podemos generar el reporte de reorder?
select reorder_level, p.product_name, p.quantity_per_unit, p.unit_price*p.units_in_stock as costo from products p, suppliers s group by p.product_id ;

---A donde va nuestro env�o m�s voluminoso?
SELECT *
FROM ( SELECT order_id, o.freight, o.ship_city, o.ship_country,
              ROW_NUMBER() OVER (ORDER BY o.freight  DESC) rn
       FROM orders o
     ) T
WHERE T.rn = 1;

---C�mo creamos una columna en customers que nos diga si un cliente es bueno, regular, o malo?
---Los mejores clientes son los que mas gastan en nuestros productos, pero tambien pudieramos usar otros criterios como:
------Los clientes que nos compran productos con mayores profit margins
------Los clientes mas frecuentes
------El numero de ordenes, etc.
select o.customer_id, sum((od.unit_price - od.unit_price*od.discount)*od.quantity) as compras_totales,
CASE
    WHEN sum((od.unit_price - od.unit_price*od.discount)*od.quantity) > 20000000 THEN 'Bueno'
    WHEN sum((od.unit_price - od.unit_price*od.discount)*od.quantity) < 10000000 THEN 'Malo'
    else 'Regular'
end as calificacion
from order_details od, orders o group by o.customer_id ;


---Qu� colaboradores chambearon durante las fiestas de navidad?
select e.employee_id
from employees e, orders o
WHERE CAST(o.order_date  AS text) like '%-12-25'
group by e.employee_id 

---Qu� productos mandamos en navidad?
select o.order_date, p.product_id 
from orders o, products p 
WHERE CAST(o.shipped_date AS text) like '%-12-25'
-------En realidad no se mando nada en navidad

---Qu� pa�s recibe el mayor volumen de producto?
select o.ship_country, sum(o.freight) from orders o group by o.ship_country order by sum(o.freight) desc limit 1