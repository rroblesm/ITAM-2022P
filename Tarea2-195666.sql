CREATE TABLE superheroes_anios_servicio (
  nombre varchar(50) NOT null,
  equipo varchar(50) NOT null,
  anios_servicio numeric(8) not null 
  );
  
INSERT INTO superheroes_anios_servicio (nombre, equipo, anios_servicio)
values
('Tony Stark', 'Avengers', 10),
('Wanda Maximoff', 'Avengers', 5),
('Wanda Maximoff', 'X Men', 3),
('Erik Lensherr', 'Acolytes', 10),
('Erik Lensherr','Brotherhood of Evil Mutants', 12),
('Natasja Romanov','KGB', 8),
('Natasja Romanov','Avengers', 10);


--Validando los datos y checando suma conjunta sin lista de grupos
select * from superheroes_anios_servicio;
select nombre,sum(anios_servicio) from superheroes_anios_servicio group by nombre;

select nombre,sum(anios_servicio), string_agg(equipo, ', ') AS lista_equipos from superheroes_anios_servicio group by nombre;


