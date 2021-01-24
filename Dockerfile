# Base:

FROM mcr.microsoft.com/dotnet/core/sdk AS base
WORKDIR /app
EXPOSE 5000
EXPOSE 5001
ENV ASPNETCORE_URLS=http://*:5000

# Build:

FROM base As build
COPY . ./src
RUN dotnet build src/TodoApi.csproj -c Release -o /app/build

# Publish:

FROM build AS publish
RUN dotnet publish src/TodoApi.csproj -c Release -o /app/publish

# Run:

FROM base AS final
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "TodoApi.dll"]