# Step1. Copy schema file onto the IIS schema directory. NOTE: I assumed the container OS is installed on C: drive and all IIS features are installed already.
copy C:\temp\config\schema\aspnetcore_schema.xml C:\windows\system32\inetsrv\config\schema
 
# Step2. Initialize variable
import-module iisadministration 
$aspNetCoreHandlerFilePath="C:\temp\aspnetcore.dll"
reset-IISServerManager -confirm:$false
$sm = Get-IISServerManager

# Step3. (Optional) Add AppSettings section. NOTE: this is only for Nano or Nano Container. If you use Server Core Container, you should not run this step
# $sm.GetApplicationHostConfiguration().RootSectionGroup.Sections.Add("appSettings")
 
# Step4. Unlock handlers section
$appHostconfig = $sm.GetApplicationHostConfiguration()
$section = $appHostconfig.GetSection("system.webServer/handlers")
$section.OverrideMode="Allow"
 
# Step5. Add aspNetCore section to system.webServer
$sectionaspNetCore = $appHostConfig.RootSectionGroup.SectionGroups["system.webServer"].Sections.Add("aspNetCore")
$sectionaspNetCore.OverrideModeDefault = "Allow"
$sm.CommitChanges()
 
# Step6. Add to globalModules
Reset-IISServerManager -confirm:$false
$globalModules = Get-IISConfigSection "system.webServer/globalModules" | Get-IISConfigCollection
New-IISConfigCollectionElement $globalModules -ConfigAttribute @{"name"="AspNetCoreModule";"image"=$aspNetCoreHandlerFilePath}
 
# Step7. Add to modules
$modules = Get-IISConfigSection "system.webServer/modules" | Get-IISConfigCollection
New-IISConfigCollectionElement $modules -ConfigAttribute @{"name"="AspNetCoreModule"} 
