CREATE PROCEDURE insertar_proyecto
(
    IN nombre_in VARCHAR(100),
    IN objetivo_general_in VARCHAR(100),
    IN metodologia_in VARCHAR(100),
    IN max_participantes_in INT,
    IN fecha_inicio_in DATE,
    IN fecha_fin_in DATE,
    IN ID_Org_Vinculada_in INT,
    IN ID_Responsable_in INT,
    OUT ID_generado_out INT
)
    SQL SECURITY INVOKER
BEGIN
INSERT INTO proyecto
    (
     nombre, objetivo_general, metodologia, max_participantes,
     fecha_inicio, fecha_fin, ID_Org_Vinculada, ID_Responsable
    )
VALUES
    (
     nombre_in, objetivo_general_in, metodologia_in, max_participantes_in,
     fecha_inicio_in, fecha_fin_in, ID_Org_Vinculada_in, ID_Responsable_in
    );
SET ID_generado_out = LAST_INSERT_ID();
END
//

CREATE PROCEDURE actualizar_proyecto
(
    IN ID_Proyecto_in INT,
    IN nombre_in VARCHAR(100),
    IN objetivo_general_in VARCHAR(100),
    IN metodologia_in VARCHAR(100),
    IN max_participantes_in INT,
    IN fecha_inicio_in DATE,
    IN fecha_fin_in DATE,
    IN ID_Org_Vinculada_in INT,
    IN ID_Responsable_in INT
)
    SQL SECURITY INVOKER
BEGIN
UPDATE proyecto SET
                    nombre = nombre_in,
                    objetivo_general = objetivo_general_in,
                    metodologia = metodologia_in,
                    max_participantes = max_participantes_in,
                    fecha_inicio = fecha_inicio_in,
                    fecha_fin = fecha_fin_in,
                    ID_Org_Vinculada = ID_Org_Vinculada_in,
                    ID_Responsable = ID_Responsable_in
WHERE ID_Proyecto = ID_Proyecto_in;
END
//

CREATE VIEW vista_estudiante_proyecto_ov_responsable AS
SELECT
    e.ID_Estudiante AS ID_Estudiante,
    e.nombre AS nombre_estudiante,
    e.matricula AS matricula,
    o.ID_Org_Vinculada AS ID_Org_Vinculada,
    o.nombre AS nombre_organizacion,
    o.direccion AS direccion,
    p.ID_Proyecto AS ID_Proyecto,
    p.nombre AS nombre_proyecto,
    p.fecha_inicio AS fecha_inicio,
    r.ID_Responsable AS ID_Responsable,
    r.nombre AS nombre_responsable,
    r.puesto AS puesto_responsable,
    r.departamento AS departamento_responsable
FROM estudiante e
         JOIN proyecto p ON e.ID_Proyecto = p.ID_Proyecto
         JOIN organizacion_vinculada o ON p.ID_Org_Vinculada = o.ID_Org_Vinculada
         JOIN responsable_tecnico r ON p.ID_Responsable = r.ID_Responsable;

CREATE TABLE oficio_asignacion (
    ID_Oficio INT AUTO_INCREMENT PRIMARY KEY,
    ID_Periodo INT NOT NULL,
    ID_Estudiante INT NOT NULL,
    documento LONGBLOB NOT NULL,
    FOREIGN KEY (ID_Periodo) REFERENCES periodo(ID_Periodo),
    FOREIGN KEY (ID_Estudiante) REFERENCES estudiante(ID_Estudiante)
);

ALTER TABLE oficio_asignacion
    ADD CONSTRAINT uq_estudiante_periodo UNIQUE (ID_Estudiante, ID_Periodo);

CREATE VIEW vista_estudiantes_asignados AS
SELECT
    e.ID_Estudiante, e.nombre AS 'estudiante', e.semestre, e.promedio,
    p.ID_Proyecto, p.nombre AS 'proyecto', p.max_participantes FROM estudiante e
JOIN proyecto p
ON e.ID_Proyecto = p.ID_proyecto;

CREATE VIEW vista_asignaciones_lugares AS
SELECT ID_Proyecto, count(ID_Proyecto) AS num_asignaciones, max_participantes FROM vista_estudiantes_asignados
GROUP BY ID_proyecto, max_participantes;

CREATE VIEW vista_lugares_disponibles AS
SELECT ID_Proyecto, max_participantes - num_asignaciones AS lugares_disponibles FROM vista_asignaciones_lugares;

CREATE PROCEDURE consultar_proyectos_disponibles()
SQL SECURITY INVOKER
BEGIN
SELECT p.ID_Proyecto, p.nombre, p.max_participantes, p.fecha_inicio, p.fecha_fin, vlp.lugares_disponibles FROM Proyecto p
    JOIN vista_lugares_disponibles vlp
    ON p.ID_Proyecto = vlp.ID_Proyecto
    WHERE (NOW() BETWEEN fecha_inicio AND fecha_fin) AND lugares_disponibles > 0;
END
//