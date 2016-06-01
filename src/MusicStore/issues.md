With SQL connection string for SQL Express in a local container:
```
PS C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore> dotnet run
Project MusicStore (.NETCoreApp,Version=v1.0) was previously compiled. Skipping compilation.
Unhandled Exception: System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocati
on. ---> System.AggregateException: One or more errors occurred. (A network-related or instance-specific error occurred
while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance
name is correct and that SQL Server is configured to allow remote connections. (provider: SQL Network Interfaces, error:
 52 - Unable to locate a Local Database Runtime installation. Verify that SQL Server Express is properly installed and t
hat the Local Database Runtime feature is enabled.)) ---> System.Data.SqlClient.SqlException: A network-related or insta
nce-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessibl
e. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: SQ
L Network Interfaces, error: 52 - Unable to locate a Local Database Runtime installation. Verify that SQL Server Express
 is properly installed and that the Local Database Runtime feature is enabled.) ---> System.ComponentModel.Win32Exceptio
n: The system cannot find the file specified
   --- End of inner exception stack trace ---
   at System.Data.SqlClient.SqlInternalConnectionTds..ctor(DbConnectionPoolIdentity identity, SqlConnectionString connec
tionOptions, Object providerInfo, Boolean redirectedUserInstance, SqlConnectionString userConnectionOptions, SessionData
 reconnectSessionData, Boolean applyTransientFaultHandling)
   at System.Data.SqlClient.SqlConnectionFactory.CreateConnection(DbConnectionOptions options, DbConnectionPoolKey poolK
ey, Object poolGroupProviderInfo, DbConnectionPool pool, DbConnection owningConnection, DbConnectionOptions userOptions)

   at System.Data.ProviderBase.DbConnectionFactory.CreatePooledConnection(DbConnectionPool pool, DbConnection owningObje
ct, DbConnectionOptions options, DbConnectionPoolKey poolKey, DbConnectionOptions userOptions)
   at System.Data.ProviderBase.DbConnectionPool.CreateObject(DbConnection owningObject, DbConnectionOptions userOptions,
 DbConnectionInternal oldConnection)
   at System.Data.ProviderBase.DbConnectionPool.UserCreateRequest(DbConnection owningObject, DbConnectionOptions userOpt
ions, DbConnectionInternal oldConnection)
   at System.Data.ProviderBase.DbConnectionPool.TryGetConnection(DbConnection owningObject, UInt32 waitForMultipleObject
sTimeout, Boolean allowCreate, Boolean onlyOneCheckConnection, DbConnectionOptions userOptions, DbConnectionInternal& co
nnection)
   at System.Data.ProviderBase.DbConnectionPool.WaitForPendingOpen()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.EntityFrameworkCore.Storage.RelationalConnection.<OpenAsync>d__32.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.EntityFrameworkCore.Storage.Internal.SqlServerDatabaseCreator.<ExistsAsync>d__13.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at Microsoft.EntityFrameworkCore.Storage.RelationalDatabaseCreator.<EnsureCreatedAsync>d__23.MoveNext()
--- End of stack trace from previous location where exception was thrown ---
   at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)
   at System.Runtime.CompilerServices.TaskAwaiter`1.GetResult()
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



With inMemoryStore = true:

```
PS C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore> dotnet run
Project MusicStore (.NETCoreApp,Version=v1.0) will be compiled because inputs were modified
Compiling MusicStore for .NETCoreApp,Version=v1.0
C:\Program Files\dotnet\dotnet.exe compile-csc @C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\obj\Debug\netcor
eapp1.0\dotnet-compile.rsp returned Exit Code 1
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(18,18): error
CS0101: The namespace 'MusicStore.Areas.Admin.Controllers' already contains a definition for 'StoreManagerController'
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(16,6): error C
S0579: Duplicate 'Area' attribute
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(20,16): error
CS0111: Type 'StoreManagerController' already defines a member called '.ctor' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(29,42): error
CS0111: Type 'StoreManagerController' already defines a member called 'Index' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(41,42): error
CS0111: Type 'StoreManagerController' already defines a member called 'Details' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(77,30): error
CS0111: Type 'StoreManagerController' already defines a member called 'Create' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(87,42): error
CS0111: Type 'StoreManagerController' already defines a member called 'Create' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(114,42): error
 CS0111: Type 'StoreManagerController' already defines a member called 'Edit' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(134,42): error
 CS0111: Type 'StoreManagerController' already defines a member called 'Edit' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(155,42): error
 CS0111: Type 'StoreManagerController' already defines a member called 'RemoveAlbum' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(169,42): error
 CS0111: Type 'StoreManagerController' already defines a member called 'RemoveAlbumConfirmed' with the same parameter ty
pes
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(188,31): error
 CS0111: Type 'StoreManagerController' already defines a member called 'GetCacheKey' with the same parameter types
C:\Users\Patrick\Source\Repos\MusicStore\src\MusicStore\Areas\Admin\Controllers\StoreManagerController.cs(200,42): error
 CS0111: Type 'StoreManagerController' already defines a member called 'GetAlbumIdFromName' with the same parameter type
s

Compilation failed.
    0 Warning(s)
    13 Error(s)

Time elapsed 00:00:01.9221529
```
