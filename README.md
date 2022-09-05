# Cooking Camel

**Name:** Dmitriy Chernikov

**Email:** chernikov.d@northeastern.edu

**Preferred Name:** Dmitriy Chernikov

### About/Overview

It is the ultimate platform for sharing and looking for recipes.
The goal of this platform is to make cooking less of a hassle for users.
Assume a user has an assortment of random ingredients around their kitchen.
The platform allows him to find recipes matching them partially or fully.
It also allows you to create recipes, make recipe favorites, look for trending ones, and other stuff.

### Prerequisites

1) `Java 11`
2) `Apache Maven`
3) `Docker`

### Technology stack

1) `Java 11, Spring Framework (Core, Data, MVC, Security, Boot)`
2) `PostgreSQL, Flyway Database Migration`
3) `Lombok, JWT, OpenAPI 3.0` 
4) `Apache Maven`
5) `Docker`

### List of Features

1) `POST /authentication/sign-in`: authentication by username and password
2) `POST /api/users`: signing up by providing basic personal information
3) `PUT /api/users`: updating basic personal information (for authenticated users only)
4) `GET /api/ingredients`: looking for ingredients by part of their names (for authenticated users only)
5) `POST /api/ingredients`: adding an ingredient by its name (for authenticated users only)
6) `GET /api/recipes`: looking for recipes by ingredients used (for authenticated users only)
7) `PUT /api/recipes`: updating your recipe (for authenticated users only)
8) `POST /api/recipes`: creating your recipe (for authenticated users only)
9) `GET /api/recipes/favorites`: looking for your favorite recipes (for authenticated users only)
10) `POST /api/recipes/favorites/{id}`: adding a recipe to your favorite recipes (for authenticated users only)
11) `DELETE /api/recipes/favorites/{id}`: removing a recipe from your favorite recipes (for authenticated users only)
12) `GET /api/recipes/trending`: looking for trending recipes for a certain period (for authenticated users only)

To see the detailed information about the given endpoints, run the application and go to `http://localhost:8080/cooking-camel/swagger-ui.html`. 

### How to Run

1) Open a terminal in any folder you like and run the following commands
2) `git clone https://github.com/chernikodv/cooking-camel-backend.git`
3) `mvn clean package`
4) `docker image build -t cooking_camel_image .`
5) `docker-compose up -d`
6) Open now your favorite browser and go to `http://localhost:8080/cooking-camel/swagger-ui.html` to use Open API 3.0
7) Sign up as a new user if you don't have one, sign in to the system, and authorize by clicking the `Authorize` button and pasting the provided JWT

### How to Develop

1) Open a terminal in any folder you like and run the following commands
2) `git clone https://github.com/chernikodv/cooking-camel-backend.git`
3) `docker-compose up -d cooking_camel_postgres`
4) Make any changes you want, then run/debug the `edu.wpi.cs.dbms.CookingCamelApplication.java` class
5) Open your favorite browser and go to `http://localhost:8080/cooking-camel/swagger-ui.html` to use Open API 3.0
6) Sign up as a new user if you don't have one, sign in to the system, authorize by clicking the `Authorize` button and pasting the provided JWT, and test your changes
