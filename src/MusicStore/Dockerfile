FROM microsoft/dotnet:1.0.0-preview2-windowsservercore-sdk

RUN mkdir \MusicStore
WORKDIR \MusicStore

ADD project.json .
RUN dotnet restore --no-cache

ADD . .
RUN dotnet build

EXPOSE 5000
ENV ASPNETCORE_URLS http://0.0.0.0:5000
CMD dotnet run
