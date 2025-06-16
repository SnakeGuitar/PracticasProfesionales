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
