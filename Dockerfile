#This is base image of dotnet core application which is created by Microsoft.    
FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env   
WORKDIR /app    
# Copy csproj and restore its dependencies such as NuGet packages    
COPY *.csproj ./    
RUN dotnet restore    
# Copy complete project files and build    
COPY . ./    
RUN dotnet publish -c Release -o out    
# Build runtime image    
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2    
WORKDIR /app    
COPY --from=build-env /app/out .    
ENTRYPOINT ["dotnet", "dotnetdc.dll", "http://*:5000"]  