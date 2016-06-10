


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

### Current Issues
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