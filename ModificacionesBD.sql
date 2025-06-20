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

ALTER TABLE `practicasprofesionales`.`entrega_doc_inicial`
    CHANGE COLUMN `fecha_apertura` `fecha_apertura` DATETIME NULL DEFAULT NULL ,
    CHANGE COLUMN `fecha_limite` `fecha_limite` DATETIME NULL DEFAULT NULL;

ALTER TABLE `practicasprofesionales`.`entrega_doc_parcial`
    CHANGE COLUMN `fecha_apertura` `fecha_apertura` DATETIME NULL DEFAULT NULL ,
    CHANGE COLUMN `fecha_limite` `fecha_limite` DATETIME NULL DEFAULT NULL;

ALTER TABLE `practicasprofesionales`.`entrega_doc_final`
    CHANGE COLUMN `fecha_apertura` `fecha_apertura` DATETIME NULL DEFAULT NULL ,
    CHANGE COLUMN `fecha_limite` `fecha_limite` DATETIME NULL DEFAULT NULL;

CREATE VIEW vista_estudiantes_asignados AS
SELECT
    e.ID_Estudiante, e.nombre AS 'estudiante', e.semestre, e.promedio,
    p.ID_Proyecto, p.nombre AS 'proyecto', p.max_participantes FROM estudiante e
JOIN proyecto p
ON e.ID_Proyecto = p.ID_proyecto;

CREATE VIEW vista_proyectos_sin_asignaciones AS
SELECT
    p.ID_Proyecto, p.max_participantes - p.max_participantes AS num_asignaciones,
    p.max_participantes FROM proyecto p
LEFT JOIN estudiante e
ON p.ID_Proyecto = e.ID_Proyecto
WHERE e.ID_Proyecto IS NULL;

CREATE VIEW vista_asignaciones_lugares AS
SELECT ID_Proyecto, count(ID_Proyecto) AS num_asignaciones, max_participantes FROM vista_estudiantes_asignados
GROUP BY ID_proyecto, max_participantes;

CREATE VIEW vista_lugares_disponibles AS
SELECT ID_Proyecto, max_participantes - num_asignaciones AS lugares_disponibles FROM vista_asignaciones_lugares
UNION
SELECT ID_Proyecto, max_participantes - num_asignaciones AS lugares_disponibles FROM vista_proyectos_sin_asignaciones;