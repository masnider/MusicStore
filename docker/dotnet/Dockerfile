FROM microsoft/windowsservercore

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Install .NET Core SDK
ENV DOTNET_SDK_VERSION 1.0.0-preview2-003131
ENV DOTNET_SDK_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/preview/Binaries/$DOTNET_SDK_VERSION/dotnet-dev-win-x64.$DOTNET_SDK_VERSION.zip

ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1

RUN Invoke-WebRequest $env:DOTNET_SDK_DOWNLOAD_URL -OutFile dotnet.zip; \
	Expand-Archive dotnet.zip -DestinationPath $env:ProgramFiles'\dotnet'; \
	Remove-Item -Force dotnet.zip

RUN [Environment]::SetEnvironmentVariable('PATH', $env:ProgramFiles + '\dotnet;' + $env:PATH, [EnvironmentVariableTarget]::Machine);
