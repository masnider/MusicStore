

## Prerequisites

### Install 1.0.0-preview2 sdk on your laptop
```
Invoke-WebRequest https://go.microsoft.com/fwlink/?LinkID=809122 -outfile DotNetCore.1.0.0-SDK.Preview2-x64.exe
.\DotNetCore.1.0.0-SDK.Preview2-x64.exe
```

### Start SQL Express container
This will pull the image, then start a container named 'mssql.' The sa password will be set to 'Password1'

```
docker pull microsoft/mssql-server-2014-express-windows
docker run --name mssql -p 1433:1433 --env sa_password=Password1 microsoft/mssql-server-2014-express-windows
```

Now, get the IP address for the container running SQL. It will be needed in the next step.
```
docker inspect --format "{{ .NetworkSettings.Networks.nat.IPAddress }}" mssql
```


## Build MusicStore

Be sure to edit config.json with:
- correct internal IP & password for SQL instance

From musicstore\src\musicstore:
```
dotnet restore
dotnet publish -o .containerbuild
```

## Deploy using WebListener/Kestrel
This is the easiest way to deploy just for testing. It builds quickly, and runs only a single site.

### Build Container for MusicStore
```
docker build -t musicstore .
```

### Run Container
```
docker run -p 5000:5000 -t -d musicstore
```


## Deploy using IIS
This is recommended if you want additional features from IIS, such as serving static content.

### Build Container for MusicStore with IIS
```
docker build -t musicstore-iis -f Dockerfile.iis .
```


### Run Container
```
docker run -p 80:80 -t -d musicstore-iis
docker run -p 80:80 -it musicstore-iis cmd
```


# Tying it all together with compose
Get Docker-Compose:
```powershell
wget https://github.com/docker/compose/releases/download/1.8.0/docker-compose-Windows-x86_64.exe -UseBasicParsing -OutFile docker-compose.exe
copy .\docker-compose.exe 'C:\Program Files\docker\'
```


The docker-compose 1.8 binary seems to crash using named pipes:
```
PS C:\MusicStore\src\MusicStore> docker-compose up
Traceback (most recent call last):
  File "<string>", line 3, in <module>
  File "compose\cli\main.py", line 61, in main
  File "compose\cli\main.py", line 113, in perform_command
  File "compose\cli\main.py", line 835, in up
  File "compose\project.py", line 372, in up
  File "compose\project.py", line 539, in warn_for_swarm_mode
  File "site-packages\docker\api\daemon.py", line 33, in info
  File "site-packages\docker\utils\decorators.py", line 47, in inner
  File "site-packages\docker\client.py", line 140, in _get
  File "site-packages\requests\sessions.py", line 477, in get
  File "site-packages\requests\sessions.py", line 465, in request
  File "site-packages\requests\sessions.py", line 573, in send
  File "site-packages\requests\adapters.py", line 370, in send
  File "site-packages\requests\packages\urllib3\connectionpool.py", line 544, in urlopen
  File "site-packages\requests\packages\urllib3\connectionpool.py", line 374, in _make_request
  File "httplib.py", line 1133, in getresponse
  File "httplib.py", line 390, in __init__
  File "site-packages\docker\transport\npipesocket.py", line 99, in makefile
ValueError: buffer size must be strictly positive
docker-compose returned -1
```

As a workaround I enabled the insecure TCP port, then set DOCKER_HOST to use it
```powershell
net stop docker
. 'C:\Program Files\docker\dockerd.exe' --unregister-service
. 'C:\Program Files\docker\dockerd.exe' --register-service -H npipe:// -H 0.0.0.0:2375
net start docker
$ENV:DOCKER_HOST="localhost:2375"
```


Now, bring the service up:
```powershell
docker-compose up
```


# Current Issues

## Exceptions in System.StringNormalizationExtensions.Normalize
This issue is in Windows Server 2016 Technical Preview 5. Rebooting the container host will resolve it. It's fixed in a later build but I don't have a specific number yet.

With SQL connection string for SQL Express in a local container:
```
Unhandled Exception: System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocati
on. ---> System.AggregateException: One or more errors occurred. (Unknown error '3'.) ---> System.InvalidOperationExcept
ion: Unknown error '3'.
   at System.StringNormalizationExtensions.Normalize(String value, NormalizationForm normalizationForm)
   at Microsoft.AspNetCore.Identity.UpperInvariantLookupNormalizer.Normalize(String key)
   at Microsoft.AspNetCore.Identity.UserManager`1.FindByNameAsync(String userName)
   at MusicStore.Models.SampleData.<CreateAdminUser>d__6.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.GetResult()
   at MusicStore.Models.SampleData.<InitializeMusicStoreDatabaseAsync>d__3.MoveNext()
   --- End of inner exception stack trace ---
   at System.Threading.Tasks.Task.ThrowIfExceptional(Boolean includeTaskCanceledExceptions)
   at System.Threading.Tasks.Task.Wait(Int32 millisecondsTimeout, CancellationToken cancellationToken)
   at System.Threading.Tasks.Task.Wait()
   at MusicStore.Startup.Configure(IApplicationBuilder app)
   at MusicStore.Startup.ConfigureProduction(IApplicationBuilder app, ILoggerFactory loggerFactory)
   --- End of inner exception stack trace ---
   at System.RuntimeMethodHandle.InvokeMethod(Object target, Object[] arguments, Signature sig, Boolean constructor)
   at System.Reflection.RuntimeMethodInfo.UnsafeInvokeInternal(Object obj, Object[] parameters, Object[] arguments)
   at System.Reflection.RuntimeMethodInfo.Invoke(Object obj, BindingFlags invokeAttr, Binder binder, Object[] parameters
, CultureInfo culture)
   at Microsoft.AspNetCore.Hosting.Startup.ConfigureBuilder.Invoke(Object instance, IApplicationBuilder builder)
   at Microsoft.AspNetCore.Hosting.Internal.WebHost.BuildApplication()
   at Microsoft.AspNetCore.Hosting.WebHostBuilder.Build()
   at MusicStore.Program.Main(String[] args)
```

At this point:
- MusicStore DB was created
- Tables have been created and populated


On a later build:
```
Unhandled Exception: System.Runtime.InteropServices.SEHException: External component has thrown an exception.
   at Interop.mincore.IsNormalizedString(Int32 normForm, String source, Int32 length)
   at System.StringNormalizationExtensions.IsNormalized(String value, NormalizationForm normalizationForm)
   at Microsoft.AspNetCore.Server.Kestrel.Http.PathNormalizer.NormalizeToNFC(String path)
   at Microsoft.AspNetCore.Server.Kestrel.ServerAddress.FromUrl(String url)
   at Microsoft.AspNetCore.Server.Kestrel.KestrelServer.Start[TContext](IHttpApplication`1 application)
   at Microsoft.AspNetCore.Hosting.Internal.WebHost.Start()
   at Microsoft.AspNetCore.Hosting.WebHostExtensions.Run(IWebHost host, CancellationToken token, String shutdownMessage)
   at Microsoft.AspNetCore.Hosting.WebHostExtensions.Run(IWebHost host)
   at MusicStore.Program.Main(String[] args)
```

At this point:
- MusicStore DB was created
- Tables have been created and populated
