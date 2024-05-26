# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the solution file and project files
COPY *.sln ./
COPY . .

# Restore dependencies
RUN dotnet restore

# Build the application in 'Staging' configuration
RUN dotnet publish -c Staging -o /app/out

# Stage 2: Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Set the environment variable
ENV ASPNETCORE_ENVIRONMENT=Staging
ENV ENV ASPNETCORE_URLS=http://0.0.0.0:5088

# Expose the port your application is configured to listen on (adjust if necessary)
EXPOSE 5088

# Define the entry point for the application
ENTRYPOINT ["dotnet", "LocalizationTest.dll"]
