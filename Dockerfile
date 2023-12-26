# Use the official .NET SDK image as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj .
RUN dotnet restore

# Copy the remaining source code
COPY . .

# Build the application
RUN dotnet publish -c Release -o out

# Use the official .NET runtime image as the base image for the final stage
FROM mcr.microsoft.com/dotnet/runtime:8.0 AS runtime

# Set the working directory in the container
WORKDIR /app

# Copy the published output from the build stage to the runtime image
COPY --from=build /app/out .

# Specify the entry point for the application
ENTRYPOINT ["dotnet", "Dotnetproj.dll"]
