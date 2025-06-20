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

CREATE PROCEDURE consultar_proyectos_disponibles()
    SQL SECURITY INVOKER
BEGIN
SELECT p.ID_Proyecto, p.nombre, p.max_participantes, p.fecha_inicio, p.fecha_fin, vlp.lugares_disponibles FROM Proyecto p
                                                                                                                   JOIN vista_lugares_disponibles vlp
                                                                                                                        ON p.ID_Proyecto = vlp.ID_Proyecto
WHERE (NOW() BETWEEN fecha_inicio AND fecha_fin) AND lugares_disponibles > 0;
END
//

DELIMITER //
CREATE PROCEDURE asignar_proyecto
(
    IN ID_Proyecto_in INT,
    IN ID_Estudiante_in INT,
    OUT exito BOOLEAN
)
SQL SECURITY INVOKER
BEGIN
    DECLARE v_ID_Periodo INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;
    SET exito = false;

    -- Realizar la asignacion
    UPDATE Estudiante SET ID_Proyecto = ID_Proyecto_in WHERE ID_Estudiante = ID_Estudiante_in;

    -- Obtener el ID del Periodo Actual
    SELECT ID_Periodo
    INTO v_ID_Periodo
    FROM Periodo
    WHERE NOW() BETWEEN fecha_inicio AND fecha_fin;

    -- Cancelar si el periodo es NULL
    IF v_ID_Periodo IS NULL THEN
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = "No se encontro un periodo activo";
    END IF;

        -- Crear el Expediente del Estudiante
    INSERT INTO expediente
    (
        ID_Estudiante, ID_Periodo, estado, horas_acumuladas
    )
    VALUES
    (
        ID_Estudiante_in, v_ID_Periodo, 'Activo', 0
    );

    -- Crear las entregas iniciales
    INSERT INTO entrega_doc_inicial
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
    NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Crear las entregas parciales
    INSERT INTO entrega_doc_parcial
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
    NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Crear las entregas finales
    INSERT INTO entrega_doc_final
    (
        fecha_apertura, fecha_limite, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
    NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Crear las entregas de reportes
    -- Reporte 1
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
    1, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Reporte 2
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
    2, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Reporte 3
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
    3, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Reporte 4
    INSERT INTO entrega_reporte
    (
        num_reporte, fecha_apertura, fecha_limite, fecha_entrega, ID_Estudiante, ID_Periodo
    )
    VALUES
    (
    4, NULL, NULL, NULL, ID_Estudiante_in, v_ID_Periodo
    );

    -- Terminado
    SET exito = true;
    COMMIT;
END
//