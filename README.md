# README

Primer intento funcional de crear una app de rails que funcione dentro de su propio contenedor en docker y permita hacer cambios directamente desde el `host`.

## Imágenes utilizadas
* postgres:latest
* ruby:3.2-bullseye (intenté con alpine, pero se me dificultó instalar dependencias)

## ¿Qué contiene este contenedor?
* Una aplicación simple de rails que incluye:
  1. Se utilizó la opción -T para remover minitest como plataforma de testing.
  2. Se utilizó la opción --database=postgresql para inicializar postgres como motor de base de datos.
  3. Se instaló la gema `rspec-rails` para manejo te testing.
  4. Se instaló la gema `factory_bot_rails` para la creación de FactoryBots que facilitan el testing de modelos y controladores.
  5. Se crearon inicializadores para rspec y factory bot; al usar `rails generate` se generaran los test y factories respectivos.
  6. Se instaló `devise` como gema para manejo de autenticación, debí omitir este paso para dejar la app más estándar, lo siento.
  7. Devise asignada a modelo `User` (solo contiene correo y contraseña).
* Un archivo Dockerfile para la construcción de la imagen de la app.
* Un script que facilita la ejecución del servidor de rails.
* Un archivo `docker-compose.yml` para facilitar la construcción.

## ¿Cómo utilizar?
Primero que nada, se necesita tener tanto `docker` como `docker-compose` y `git` instalados en la máquina que quiera ser utilizada como anfitrión. Posteriormente solo es necesario realizar los siguientes pasos:
1. Clonar este repositorio de git en el directorio deseado.
2. Cambiar el directorio de trabajo hacia el recién clonado.
3. Verificar los archivos `docker-compose.yml` y `./config/database.yml` para ajustar las credenciales según se requiera (revisar documentación de docker, rails o postgres para manejo de contraseñas desde archivo o variables de entorno).
4. Ejecutar `docker-compose build` para asegurarse de que todo funciona correctamente.
5. Ejecutar `docker-compose up` para iniciar el contenedor. En caso de que se requiera puede agregar `-d` para iniciar en modo `detached`.
6. Ejecutar `docker-compose run web rails db:create` para crear la base de datos, seguido de `docker-compose run web rails db:migrate` para realizar la migración a causa del modelo User de devise.
7. Si todo salió bien, debería poder conectarse vía el IP de su `host` y el puerto `3001` (puesto como default en el docker-compose.yml). Ejemplo: 127.0.0.1:3001

## Para utilizar lo anterior pero con su propia app previamente desarrollada (aún haciendo pruebas).
De nuevo, se necesita tener instalado tanto `docker` como `docker-compose` en la máquina anfitrión. Posteriormente:
1. Copiar los siguientes archivos en la raíz de su proyecto de rails:
  * ./Dockerfile
  * ./docker-compose.yml
  * ./entrypoint.sh
2. Crear una copia del archivo `.gitignore` de su aplicación y cambiarle el nombre por `.dockerignore`. Esto hará que docker ignore la transferencia de ciertos archivos que serán creados durante el proceso.
3. Asegurarse de que las las versiones de `ruby` y `rails` coincidan entre el `Gemfile` y el `Dockerfile`.
4. Efectuar los pasos de la sección anterior a partir de el paso 2.
