-- ------- Base de dades Universidad ----
-- 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p WHERE p.tipo = "alumno" ORDER BY  p.apellido1, p.apellido2, p.nombre;
-- 2 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT p.apellido1, p.apellido2 FROM persona p WHERE p.telefono IS NULL;
-- 3 Retorna el llistat dels alumnes que van néixer en 1999.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p WHERE p.fecha_nacimiento LIKE "%1999%";
-- 4 Retorna el llistat de professors que no han donat d'alta el seu número de telèfon en la base de dades i a més la seva nif acaba en K.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p WHERE p.tipo = "profesor" AND p.telefono IS NULL  AND p.nif LIKE "%K"; 
-- 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT a.nombre FROM asignatura a WHERE a.cuatrimestre = 1 AND a.curso = 3 AND a.id_grado = 7;
-- 6 Retorna un llistat dels professors juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS Departamento FROM profesor pr INNER JOIN persona p ON pr.id_profesor = p.id INNER JOIN departamento d ON pr.id_departamento = d.id ORDER BY p.apellido1, p.apellido2, p.nombre;
-- 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne amb nif 26902806M. 
SELECT a.nombre AS Asignatura, ce.anyo_inicio, ce.anyo_fin FROM alumno_se_matricula_asignatura am INNER JOIN asignatura a ON am.id_asignatura = a.id INNER JOIN curso_escolar ce ON am.id_curso_escolar = ce.id WHERE am.id_alumno = (SELECT p.id FROM persona p WHERE p.nif = "26902806M");
-- 8 Retorna un llistat amb el nom de tots els departaments que tenen professors que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre AS Departamento FROM asignatura a INNER JOIN profesor p ON a.id_profesor = p.id_profesor INNER JOIN departamento d ON p.id_departamento = d.id WHERE a.id_grado = (SELECT g.id FROM grado g WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)" ) AND a.id_profesor IS NOT NULL;
-- 09 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019. 
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM alumno_se_matricula_asignatura ama INNER JOIN persona p ON ama.id_alumno = p.id WHERE ama.id_curso_escolar = (SELECT cs.id FROM curso_escolar cs WHERE cs.anyo_inicio = 2018 AND cs.anyo_fin = 2019);

-- ------- Resolgui les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN. -----
-- 01 Retorna un llistat amb els noms de tots els professors i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT d.nombre AS Departamento, p.nombre, p.apellido1, p.apellido2 FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor RIGHT JOIN departamento d ON d.id = pr.id_departamento WHERE p.tipo = "profesor";
-- 02 Retorna un llistat amb els professors que no estan associats a un departament.
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre AS Departamento FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor RIGHT JOIN departamento d ON d.id = pr.id_departamento WHERE p.tipo = "profesor" AND d.nombre IS NULL;
-- 03 Retorna un llistat amb els departaments que no tenen professors associats.
SELECT d.nombre AS Departamento FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento LEFT JOIN persona p ON pr.id_profesor = p.id WHERE p.tipo = "profesor" AND pr.id_profesor IS NULL;
-- 04 Retorna un llistat amb els professors que no imparteixen cap assignatura.
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE p.tipo = "profesor" AND a.id_profesor IS NULL;
-- 05 Retorna un llistat amb les assignatures que no tenen un professor assignat.
SELECT a.nombre AS Asignatura FROM asignatura a LEFT JOIN profesor pr ON a.id_profesor = pr.id_profesor LEFT JOIN persona p ON pr.id_profesor = p.id WHERE p.nombre IS NULL ORDER BY p.nombre;
-- 06 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT d.nombre AS Departamento FROM departamento d LEFT JOIN profesor pr on d.id = pr.id_departamento LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;

-- --------- Consultes resum ------
-- 01 Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) FROM persona p WHERE p.tipo = "alumno";
-- 02 Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) FROM persona p WHERE p.tipo = "alumno" AND p.fecha_nacimiento LIKE "%1999%";
-- 03 Calcula quants professors hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors associats i haurà d'estar ordenat de major a menor pel nombre de professors.
SELECT d.nombre, COUNT(pr.id_departamento) AS numero_profesores FROM departamento d INNER JOIN profesor pr ON d.id = pr.id_departamento INNER JOIN persona p ON pr.id_profesor = p.id GROUP BY d.nombre ORDER BY p.nombre;
-- 04 Retorna un llistat amb tots els departaments i el nombre de professors que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre, COUNT(pr.id_departamento) AS numero_profesores FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento  GROUP BY d.nombre;
-- 05 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingui en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre, COUNT(a.Id_grado) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY numero_asignaturas DESC;
-- 06 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre, COUNT(a.id_grado) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING (numero_asignaturas) > 40;
-- 07 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus. 
SELECT g.nombre , a.nombre AS tipo_asignatura , SUM(a.creditos) FROM grado g INNER JOIN asignatura a ON g.id = a.id_grado GROUP BY a.nombre;
-- 08 Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT ce.anyo_inicio, COUNT(ama.id_curso_escolar) AS numero_alumnos_matriculados FROM curso_escolar ce INNER JOIN alumno_se_matricula_asignatura ama ON ce.id = ama.id_curso_escolar GROUP BY ama.id_curso_escolar;
-- 09 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor. El llistat ha de tenir en compte aquells professors que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id_profesor) AS numero_asignaturas FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = "profesor" GROUP BY p.id ORDER BY numero_asignaturas DESC;
-- 11 Retorna un llistat amb els professors que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;




