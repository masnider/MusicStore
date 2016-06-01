


## Build Prerequisites
```
mkdir \dotnetcore-servercore
cd \dotnetcore-servercore
wget https://raw.githubusercontent.com/PatrickLang/dotnet-docker/windowsImages/1.0.0-rc2/windowsservercore/x64/core/Dockerfile Dockerfile
docker build -t dotnetcore:windowsservercore .
```

## Build
From musicstore\src\musicstore:
```
dotnet restore
dotnet publish -o .containerbuild
```


## Build Container
```
docker build -t musicstore .
```

## Run Container
```
docker run -p 5000:5000 -t -d musicstore
```
