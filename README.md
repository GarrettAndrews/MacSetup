# MacSetup
Shell script for deploying software and settings to computers running OSX

Download the zip folder to use, as it includes sshpass which is required for this script to run.

--------------MacSetupSED Instructions--------------
----------------------------------------------------
1. copy all files/folders to Desktop.             
2. 'cd' to the local Desktop.                     
3. Execute: chmod 700 MacSetupSED.sh              
4. Execute: 'sudo ./MacSetupSED.sh’+ ARGS.        
5. ARGS include optional apps: CrashPlanPro,      
 AdobeCC, Cisco_AnyConnect, Microsoft_Office_2016,
 Identity_Finder, Mozilla_Firefox, Managed, Unmanaged.                                       
6. Sample: ‘sudo ./MacSetupSED.sh AdobeCC         
7. Please report any unexpected errors.           
----------------------------------------------------
New: Deletes files on Desktop when finished and   
takes arguments for app options.                  
Bugs: Does not implement step 13  from the KB entry.                                            
----------------------------------------------------
USE THIS TO INSTALL ALL OPTIONAL APPS & SEP MANAGED:
sudo ./MacSetupSED.sh CrashPlanPro AdobeCC Cisco_AnyConnect Microsoft_Office_2016 Identity_Finder Mozilla_Firefox Managed
----------------------------------------------------
USE THIS TO INSTALL ALL OPTIONAL APPS & SEP UNMANAGED:
sudo ./MacSetupSED.sh CrashPlanPro AdobeCC Cisco_AnyConnect Microsoft_Office_2016 Identity_Finder Mozilla_Firefox Unmanaged
