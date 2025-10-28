# Curso de Administración de Bases de Datos en MSSQL

Este repositorio contiene archivos y scripts utilizados en un curso de administración de bases de datos, enfocado en el aprendizaje de la gestión, configuración y mantenimiento de Microsoft SQL Server (MSSQL).

## Descripción
Aquí encontrarás archivos con instrucciones y ejemplos de código SQL que cubren temas fundamentales de la administración de bases de datos:

- Creación, eliminación y uso de bases de datos.
- Configuración de instancias de SQL Server (memoria, procesadores, seguridad).
- Conceptos de colación y Unicode.
- Seguimiento y monitoreo del servidor con SQL Server Profiler.
- Administración de propiedades de la base de datos.
- Auditar una base de datos
- Autenticación en MSSQL
- Gestionar usuarios e inicios de sesion
- Gestionar roles de servidor y de bases de datos
- Autorizar y denegar acceso a objetos
- Gestión de copias de seguridad y restauración de bases de datos (DRP).
- Cifrado de datos en reposo con Transparent Data Encryption (TDE).
- Enmascaramiento de datos sensibles con Dynamic Data Masking (DDM).
- Creación y uso de Funciones, Vistas y Procedimientos Almacenados.
- Implementación de Triggers para automatizar acciones.
- Automatización de tareas administrativas con **SQL Server Agent**.
- Monitoreo de errores y manejo con bloques `TRY...CATCH`.
- Configuración de **Correo Electrónico de Base de Datos** para alertas.
- Uso de **Tablas Temporales** para mantener un historial de cambios en los datos.
- Monitoreo avanzado con **Eventos Extendidos**.

Cada archivo está diseñado para practicar y entender conceptos clave de la administración de SQL Server. Puedes abrirlos y ejecutarlos en tu entorno de SQL Server para experimentar y aprender de manera práctica.

## Modulos

- **`1-Creacion y administracion de una base de datos`**: Este módulo cubre las tareas fundamentales de un administrador de bases de datos. En concreto:
  - Crear, usar y eliminar bases de datos con comandos T-SQL (`CREATE`, `DROP`).
  - Configurar las propiedades de una instancia del servidor (memoria, procesadores, seguridad).
  - Entender qué son las colaciones y su impacto en los datos.
  - Monitorear la actividad del servidor con **SQL Server Profiler**.
  - Implementar **Auditorías** para registrar eventos de seguridad, como inicios de sesión fallidos.
- **`2-Seguridad en la BD en MSSQL`**: Este módulo se enfoca en los conceptos y prácticas para asegurar una instancia de SQL Server y sus bases de datos. En concreto:
  - Comprender los modelos de **Autenticación** (Windows y SQL Server).
  - Crear y gestionar **Inicios de Sesión** (Logins) y **Usuarios** de base de datos.
  - Administrar **Roles de Servidor** para controlar permisos a nivel de instancia.
  - Administrar **Roles de Base de Datos** para gestionar permisos dentro de una base de datos.
  - Otorgar, denegar y revocar permisos sobre objetos específicos con `GRANT`, `DENY` y `REVOKE`.
- **`3-Administración de datos`**: Este módulo se centra en la protección de los datos, las estrategias de respaldo y recuperación, y las características de seguridad para proteger la información sensible. En concreto:
  - Implementar un **Plan de Recuperación de Desastres (DRP)**, entendiendo los conceptos de RTO y RPO.
  - Realizar diferentes tipos de **Copias de Seguridad** (Full, Diferencial, Log) y **Restauraciones** de bases de datos.
  - Proteger datos en reposo mediante **Transparent Data Encryption (TDE)**.
  - Ocultar datos sensibles en los resultados de consultas con **Dynamic Data Masking (DDM)**.
- **`4-Funciones, vistas, procedimientos y triggers`**: Este módulo se enfoca en los objetos de programación que permiten encapsular lógica y automatizar tareas en la base de datos. En concreto:
  - Crear y utilizar **Funciones** (escalares y de tabla) para reutilizar código y simplificar cálculos.
  - Definir **Vistas** para simplificar consultas complejas y mejorar la seguridad de los datos.
  - Implementar **Procedimientos Almacenados** para ejecutar bloques de código T-SQL precompilados y parametrizados.
  - Desarrollar **Triggers** para automatizar acciones en respuesta a eventos de modificación de datos (`INSERT`, `UPDATE`, `DELETE`).
- **`5-Automatizar la administración`**: Este módulo explora las herramientas y técnicas para automatizar tareas administrativas repetitivas, mejorando la eficiencia y la confiabilidad. En concreto:
  - Comprender las diferentes opciones de automatización como **SQL Server Agent**, **Planes de Mantenimiento** y **PowerShell**.
  - Crear y configurar **Trabajos (Jobs)** en SQL Server Agent para ejecutar tareas programadas.
  - Definir **Pasos (Steps)** con lógica T-SQL dentro de un trabajo.
  - Programar la ejecución de trabajos mediante **Programaciones (Schedules)**.
- **`6-Monitoreo y auditorias`**: Este módulo se enfoca en las herramientas y técnicas para supervisar el rendimiento, capturar errores y auditar la actividad en SQL Server. En concreto:
  - Monitorear y capturar errores de T-SQL utilizando bloques **TRY...CATCH**.
  - Configurar el **Correo Electrónico de Base de Datos** para enviar notificaciones y alertas automáticas.
  - Implementar **Tablas Temporales (System-Versioned)** para mantener un historial completo de los cambios en los datos.
  - Crear y gestionar sesiones de **Eventos Extendidos** para un monitoreo de rendimiento ligero y avanzado, como alternativa a SQL Profiler.

  
## Uso
1. Abre los archivos `.sql` en SQL Server Management Studio (SSMS) o tu editor SQL favorito.
2. Ejecuta los scripts para practicar los comandos de administración.
3. Lee las notas para comprender a fondo los conceptos teóricos.
4. Modifica y experimenta con los ejemplos para reforzar tu aprendizaje.

---
¡Feliz aprendizaje en la administración de SQL Server!
