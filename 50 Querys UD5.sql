use SOCIOS

--5.1. Todos los datos (todos los campos de la relación AULA) de las aulas cuyo estado sea ‘Bueno’
--(estado=’B’).
select *
from AULA
where estado='B';

--5.2. Todos los datos (todos los campos de la relación ACTIVIDAD) de las actividades con precio menor de
--50 euros.
select *
from ACTIVIDADE a
where a.prezo<50;

--5.3. Nombre de las cuotas no gratuitas.
select nome
from COTA
where importe>0;

--5.4. Identificador de las actividades realizadas por el socio con número 1004.
select id_actividade
from SOCIO_REALIZA_ACTI
where num_socio=1004;

--5.5. NIF del profesor que imparte la actividad de nombre ‘TENIS’.
select e.nif
from EMPREGADO e, ACTIVIDADE a
where a.nome='XADREZ' AND
	  a.num_profesorado_imparte=e.numero

--5.6. Nombre completo de los profesores que realizan (cursan) alguna actividad.
select e.nome, e.ape1, e.ape2
from EMPREGADO e, PROFE_CURSA_ACTI p
where e.numero=p.num_profesorado;

--5.7. Importe de la cuota que debe pagar el socio número 1003.
select c.importe
from COTA c, SOCIO s 
where s.numero=1003 AND 
	  s.cod_cuota=c.codigo
--5.8. Horas extras realizadas por el empleado con NSS 151515151515
select a.horas_extras
from EMPREGADO e, ADMINISTRATIVO a
where e.nss='151515151515' AND
	  e.numero=a.num_adm
--5.9. Nombre de las actividades en las que hay morosos apuntados.
select a.nome
from ACTIVIDADE a, SOCIO_REALIZA_ACTI c
where c.pagada='n' AND 
      c.id_actividade=a.identificador
      
--5.10. Nombre y fecha de inicio de las actividades que se imparten en aulas en mal estado (estado=’M’).
select a.nome, a.data_ini
from ACTIVIDADE a, AULA l
where l.estado='M' AND
      a.num_aula = l.numero
--5.11. Nombre completo, dirección, profesión y tipo de aquellos socios que deben la cuota anual.
select [nome], [ape1], [ape2], [tipo_via_enderezo], [rua_enderezo], [num_casa_enderezo], [piso_enderezo], [localidade_enderezo], [codpostal_enderezo], [cod_provincia_enderezo], [profesion]
from  SOCIO s
where s.abonada='n'
      
--5.12. Salario del profesor que imparte la actividad de nombre ‘COCINA’.
select e.salario_mes
from EMPREGADO e, ACTIVIDADE c
where e.numero=c.num_profesorado_imparte AND
      c.nome='REPOSTARÍA'

--5.13. Plazas de las actividades que imparte el profesor con NIF ‘22222222B’.
select a.num_prazas
from ACTIVIDADE a, EMPREGADO e
where e.nif='22222222B' AND
      a.num_profesorado_imparte=e.numero

--5.14. Nombre de las actividades que empiezan antes del 12 de diciembre de 2005, es decir con fecha de
--inicio menor que esa.
select a.nome
from ACTIVIDADE a
where a.data_ini< '2015-01-01'

--5.15. Nombre completo de todas las personas que pueden cursar actividades.
select s.nome, s.ape1, s.ape2
from SOCIO s
union all
select e.nome, e.ape1, e.ape2
from EMPREGADO e
where e.cargo='PRF';

--5.16. NIF, NSS y nombre completo de todos aquellos profesores que no cursan actividades.
select e.nif, e.nss, e.nome, e.ape1, e.ape2
from EMPREGADO e
where e.cargo='PRF' AND
      e.numero not in (select p.num_profesorado
						from PROFE_CURSA_ACTI p);

select e.nif, e.nss, e.nome, e.ape1, e.ape2
from EMPREGADO e
where e.cargo='PRF'
except
select e.nif, e.nss, e.nome, e.ape1, e.ape2
from EMPREGADO e, PROFE_CURSA_ACTI p
where p.num_profesorado = e.numero

--5.17. Nombre de la actividad y nombre completo del profesor que la imparte, para aquellas actividades
--cursadas por algún profesor.
select a.nome, e.nome
from PROFE_CURSA_ACTI p, ACTIVIDADE a, EMPREGADO e
where a.num_profesorado_imparte = e.numero AND
      a.identificador = p.id_actividade
	  

--5.18. Nombre de cada actividad, nombre completo del profesor que la imparte y descripción del aula que
--tiene asignada.
select a.nome, e.nome, e.ape1, e.ape2, l.descricion
from ACTIVIDADE a, EMPREGADO e, Aula l
where a.num_aula=l.numero and e.numero=a.num_profesorado_imparte

--5.19. Número y nombre completo de todos los socios que están apuntados a actividades que comenzaron
--antes del mes de julio de 2005.
select s.nome, s.ape1, s.ape2, s.numero
from SOCIO s, ACTIVIDADE a, SOCIO_REALIZA_ACTI t
where s.numero=t.num_socio and a.data_ini<'2015-02-15'

--5.20. Nombre completo de aquellos socios que cursan actividades impartidas en aulas con superficie
--superior a 50 metros cuadrados.
select distinct s.nome, s.ape1, s.ape2
from SOCIO s, AULA a, SOCIO_REALIZA_ACTI r, ACTIVIDADE d
where s.numero=r.num_socio and a.superficie>50
      and d.num_aula=a.numero and r.id_actividade=d.identificador

--5.21. NSS de los profesores que imparten clase en aulas en mal estado(estado=’M’).
select e.nss
from EMPREGADO e, ACTIVIDADE a, AULA l 
where e.numero=a.num_profesorado_imparte and a.num_aula=l.numero and l.estado='M'

--5.22. NSS de los socios que tienen asignadas cuotas gratuitas.
select s.nss
from SOCIO s, COTA c
where c.codigo=s.cod_cuota

--5.23. Nombre completo de TODAS las personas de la sociedad cultural y deportiva que viven en
--Bertamiráns.
select e.nome, e.ape1, e.ape2
from EMPREGADO e
where e.localidade_enderezo='A Coruña' 
union
select s.nome, s.ape1, s.ape2 
from SOCIO s
where s.localidade_enderezo='A Coruña'

--5.24. Número identificativo de los profesores que cursan actividades.
select e.numero
from EMPREGADO e, PROFE_CURSA_ACTI p
where e.numero=p.num_profesorado

--5.25. Número identificativo de aquellos profesores que no cursan actividades.
--revisar
select e.numero
from EMPREGADO e, PROFE_CURSA_ACTI p
where e.numero!=p.num_profesorado

--5.26. Nombre completo y localidad de los socios que asisten a la actividad ‘COCINA’.
select s.nome, s.ape1, s.ape2, s.localidade_enderezo
from SOCIO s, SOCIO_REALIZA_ACTI c, ACTIVIDADE a
where c.id_actividade = a.identificador 
and a.nome = 'XADREZ' 
and s.numero = c.num_socio

--5.27. Nombre completo y localidad de los profesores que asisten a la actividad ‘COCINA’.
select e.nome, e.ape1, e.ape2, e.localidade_enderezo
from PROFE_CURSA_ACTI pca, EMPREGADO e, ACTIVIDADE a
where pca.id_actividade = a.identificador
and a.nome = 'XADREZ'
and pca.num_profesorado = e.numero

--5.28. Nombre completo y localidad de las personas de la sociedad cultural y deportiva que asisten a la
--actividad ‘COCINA’.
select s.nome, s.ape1, s.ape2, s.localidade_enderezo
from SOCIO s, SOCIO_REALIZA_ACTI c, ACTIVIDADE a
where c.id_actividade = a.identificador 
and a.nome = 'XADREZ' 
and s.numero = c.num_socio
UNION
select e.nome, e.ape1, e.ape2, e.localidade_enderezo
from PROFE_CURSA_ACTI pca, EMPREGADO e, ACTIVIDADE a
where pca.id_actividade = a.identificador
and a.nome = 'XADREZ'
and pca.num_profesorado = e.numero

--5.29. NIF y nombre de los administrativos que no han hecho horas extras.
select e.nif, e.nome, e.ape1, e.ape2
from EMPREGADO e, ADMINISTRATIVO a
where a.num_adm = e.numero 
and a.horas_extras is null

--5.30. Nombre completo de los profesores de la especialidad de ‘IDIOMAS’.
select e.nome, e.ape1, e.ape2, p.especialidade
from PROFESORADO p, EMPREGADO e
where p.especialidade = 'DEPORTES'
and p.num_prof = e.numero

--5.31. Nombre completo de los administrativos que han hecho horas extras.
select e.nome, e.ape1, e.ape2
from EMPREGADO e, ADMINISTRATIVO a
where a.num_adm = e.numero and a.horas_extras>0

--5.32. Nombre completo de los profesores de la especialidad ‘IDIOMAS’ y administrativos que han hecho
--horas extras.
select e.nome, e.ape1, e.ape2
from EMPREGADO e, PROFESORADO p
where p.num_prof = e.numero and p.especialidade = 'DEPORTES'
UNION
select e.nome, e.ape1, e.ape2
from EMPREGADO e, ADMINISTRATIVO a
where a.num_adm = e.numero and a.horas_extras>0

--5.33. Nombre y NIF de los administrativos que viven en Santiago de Compostela y que han hecho horas
--extras.
select e.nome, e.ape1, e.ape2
from EMPREGADO e, ADMINISTRATIVO a
where a.horas_extras>0 and e.localidade_enderezo = 'SANTIAGO DE COMPOSTELA'

--5.34. Nombre y NIF de los administrativos que viven en Santiago de Compostela y que NO han hecho horas
--extras.
select e.nome, e.ape1, e.ape2, e.nif
from EMPREGADO e, ADMINISTRATIVO a
where e.localidade_enderezo = 'SANTIAGO'
and e.numero=a.num_adm
and horas_extras = 50

--5.35. Nombre y teléfonos de los profesores con sueldo superior a 1.200€.
select e.nome, e.ape1, e.ape2, e.tel_fixo, e.tel_mobil
from EMPREGADO e, PROFESORADO p
where e.numero = p.num_prof and e.salario_mes > 1200

--5.36. Nombre de las actividades de las que se desconoce quién las va a impartir. 
--???????????????????????????????????????????????????
select a.nome
from ACTIVIDADE a
where a.num_profesorado_imparte is null

--5.37. Nombre de las actividades que tienen profesor asignado. Hazlo de 2 maneras, en la primera usando el
--operador de selección y en la segunda usando el operador diferencia.
select a.nome
from ACTIVIDADE a, PROFESORADO p
where p.num_prof = a.num_profesorado_imparte

select a.nome
from ACTIVIDADE a
where a.num_profesorado_imparte is not null

--5.38. Nombre y teléfono de los socios que asisten a clase de actividades con más de 10 plazas.
select s.nome, s.ape1, s.ape2, s.telefono1, s.telefono2
from SOCIO s, SOCIO_REALIZA_ACTI sa, ACTIVIDADE a
where s.numero = sa.num_socio and a.identificador= sa.id_actividade and a.num_prazas>10


--5.39. Importe de las cuotas anuales asignadas a socios nacidos antes del año 2000.
select c.importe
from COTA c, SOCIO s
where s.data_nac<'01-01-2000'

--5.40. Nombre e importe de la/s cuota/s asignada/s a los socios de tipo COMÚN.
select c.nome, c.importe, s.tipo
from COTA c, SOCIO s
where s.tipo = 'COMÚN' and s.cod_cuota = c.codigo

--5.41. Nombre de las actividades a las que asisten socios que tienen asignadas cuotas anuales gratuitas.
select
from
where
--5.42. NIF y NSS de los profesores que imparten actividades en las que están matriculados socios que deben
--la cuota anual.
--5.43. Nombre completo de los socios de los que se desconoce su profesión.
--5.44. Nombre completo y fecha de nacimiento de los socios que no participan en actividades.
--5.45. Nombre completo y fecha de nacimiento de los socios que participan en actividades de precio
--superior a 100€.
--5.46. Actividades sin observaciones a resaltar.
--5.47. Nombre de la actividad que se imparte en el AULA número 6.
--5.48. Nombre e importe de la/s cuota/s asignada/s a los socios que deben alguna actividad.
--5.49. Nombre y teléfonos de los profesores con sueldo inferior a 1.200€ y que asisten a actividades.
--5.50. Información completa de los administrativos que trabajan en la sociedad.