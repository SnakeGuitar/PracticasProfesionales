### Instrucciones ###
Preparacion de la Base de Datos:

1: En MySQL, crear una base de datos llamada `practicasprofesionales`, comando:
`CREATE DATABASE practicasprofesionales`

2: Cargar datos a la base con el script `BD_PracticasProfesionales.sql`, 
comando: `mysql –u  root  –p  practicasprofesionales  <  "\..\BD_PracticasProfesionales.sql"`

3: En la copia local del repositorio, ir a la clase `ConexionBD` en la ruta *"src/main/java/sgpp/modelo/ConexionBD.java"*

4: Allí, modificar las variables `DEFAULT_USERNAME` y `DEFAULT_PASSWORD`,
y colocar las credenciales de una cuenta con permisos `SELECT`, `INSERT`,
`UPDATE` y `EXECUTE` en `practicasprofesionales`

5: Los usuarios y sus credenciales puede crear nuevos, actualizar los existentes o utilizar los del archivo *LEÉME.txt*
(no incluido en este repositorio)

6: Puede crear nuevos usuarios para hacer llamando al procedimiento `CALL insertar_usuario('[usuario]', '[password]', '[COORDINADOR/ESTUDIANTE/PROFESOR]', 1);`
en `practicasprofesionales`
