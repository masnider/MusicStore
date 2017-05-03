MusicStore (Sample ASP.NET Core application)
============================================
This is a cut-down version of the MusicStore application, designed to demonstrate aspnetcore integration with containers, as well as container integration with Service Fabric.

If you're mainly interested in the result, you can check out the prebuilt container via the compose file we've defined for you: docker-compose-musicstore-windows-prebuilt.yml

This sample demonstrates
- Building a Windows Server container application containing a asp.net core application
- A multi-container application defined with docker-compose
- Various means of running those containers and orchestrating them with Service Fabric