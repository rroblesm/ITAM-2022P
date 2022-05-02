CREATE TABLE heroes_marvel (
  id_heroes_marvel numeric(4),
  nombre_completo varchar(50) NOT null,
  email varchar(320) not null
  );
CREATE SEQUENCE heroes_marvel_id_heroes_marvel_seq START 1 INCREMENT 1 ;
ALTER TABLE heroes_marvel ALTER COLUMN id_heroes_marvel SET DEFAULT nextval('heroes_marvel_id_heroes_marvel_seq');


INSERT INTO heroes_marvel (nombre_completo, email)
values
('Wanda Maximoff', 'wanda.maximoff@avengers.org'),
('Pietro Maximoff', 'pietro@mail.sokovia.ru'),
('Erik Lensherr', 'fuck_you_charles@brotherhood.of.evil.mutants.space'),
('Charles Xavier', 'i.am.secretely.filled.with.hubris@xavier-school-4-gifted-youngste.'), --invalido, acaba con punto
('Anthony Edward Stark', 'iamironman@avengers.gov'),
('Steve Rogers', 'americas_ass@anti_avengers'), --invalido, no hay direccion
('The Vision', 'vis@westview.sword.gov'),
('Clint Barton', 'bul@lse.ye'), --asumire que es valido, ya que varios sitios lo toman como valido
('Natasja Romanov', 'blackwidow@kgb.ru'), 
('Thor', 'god_of_thunder-^_^@royalty.asgard.gov'), --Es valido? no estoy 100% seguro debido a los caracteres ^ ^
('Logan', 'wolverine@cyclops_is_a_jerk.com'), 
('Ororo Monroe', 'ororo@weather.co'),
('Scott Summers', 'o@x'), --invalido
('Nathan Summers', 'cable@xfact.or'), --dudoso
('Groot', 'iamgroot@asgardiansofthegalaxyledbythor.quillsux'),
('Nebula', 'idonthaveelektras@complex.thanos'), --dudoso
('Gamora', 'thefiercestwomaninthegalaxy@thanos.'), --invalido, acaba con punto
('Rocket', 'shhhhhhhh@darknet.ru');

select * from heroes_marvel;


-----Primer Validacion
SELECT * FROM heroes_marvel
WHERE email 
LIKE '%_@__%.__%';
---Valida los emails que tengan la forma de (nombre)@(email con punto ni al principio ni al final)

--- Segunda validacion, con Case
select *, 
  CASE 
  WHEN email LIKE '%_@_%_.__%' AND email NOT LIKE '%^%' 
  THEN 'Valido' 
  ELSE 'Invalido' 
  END as es_valido
FROM heroes_marvel;