# Usar una imagen base de Maven para la construcción
FROM maven:3.8.4-openjdk-11 AS build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo pom.xml y las dependencias de Maven
COPY pom.xml .
COPY src ./src

# Compilar la aplicación
RUN mvn clean package -DskipTests

# Usar una imagen base de JDK para ejecutar la aplicación
FROM openjdk:11-jre-slim

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo JAR desde la imagen de construcción
COPY --from=build /app/target/holaMundoSpring-0.0.1-SNAPSHOT.jar /app/app.jar

# Exponer el puerto que la aplicación utiliza
EXPOSE 8080

# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
