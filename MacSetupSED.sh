function pause(){
read -p "$*"
}
pause 'Please finish drive encryption before starting this script. Press [ENTER] to continue: '
echo "---BEGIN MODIFICATION OF SYSTEM FILES---"
sed -ie '/file_max=5M all_max=50M/ s/$/ ttl=90/' /etc/asl.conf
sed -ie '/file_max=5M all_max=20M/ s/$/ ttl=90/' /etc/asl/com.apple.authd
launchctl load -w /System/Library/LaunchDaemons/com.apple.auditd.plist
sed -ie '/flags:lo,aa/ s/$/,lo,ad,fd,fm,-all/' /etc/security/audit_control
sed -ie '/install.log format=bsd/ s/$/ ttl=365/' /etc/asl/com.apple.install
apachectl stop
defaults write /System/Library/LaunchDaemons/org.apache.httpd Disabled -bool true
launchctl unload -w /System/Library/LaunchDaemons/ftp.plist
nfsd disable
rm /etc/export
find /System -type d -perm -2 -ls | grep -v "Public/Drop Box"
sed -ie 's/.*account    required       pam_group.so no_warn group=admin,wheel fail_safe.*/account    required       pam_group.so no_warn group=wheel fail_safe/' /etc/pam.d/screensaver
pwpolicy -setglobalpolicy "minChars=8 requiresNumeric=1 requiresAlpha=1 requiresSymbol=1"
# USER LOGIN SCREEN MESSAGE # 
defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Authorized users only. Actual or attempted unauthorized use of this computer system may result in criminal and/or civil prosecution or University disciplinary action. We reserve the right to view, monitor, and record activity on this site without notice or permission. If you are not an authorized user of this system, exit the system at this time."
defaults write com.apple.Safari AutoOpenSafeDownloads -boolean no
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users local -privs -all -restart -agent -menu
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist
sudo dseditgroup -o edit -n /Local/Default -u local -p -a local -t user com.apple.access_ssh
echo "---SYSTEM FILE MODIFICATION COMPLETE---"
make
osascript -e "set Volume 3"
say -v Bells "beep"
pause 'Press [Enter] to continue once Command Line Tools has finished installing...'
cd sshpass-1.05
./configure
make install
cd
cd Desktop
echo "Fetching applications... (this may take a few minutes)"
CPP="F"
ACC="F"
CAC="F"
MSO="F"
IF="F"
MFF="F"
SEPM="F"
SEPU="F"
for VAR in $@
do
        if [ "$VAR" = "CrashPlanPro" ]
        then
                echo "copying Crashplan..."
		sshpass -p "server password here" scp -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/Crashplan/CrashPlanPROe_Mac.dmg ~/Desktop
		chown -Rv local ~/Desktop/CrashPlanProe_Mac.dmg
		CPP="T"
		echo "complete..."
        fi
        if [ "$VAR" = "AdobeCC" ]
        then
                echo "copying AdobeCC..."
		sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/AdobeCC_Mac_Design_22JUL2015 ~/Desktop
		chown -Rv local ~/Desktop/AdobeCC_Mac_Design_22JUL2015
		ACC="T"
		echo "complete..."
        fi
        if [ "$VAR" = "Cisco_AnyConnect" ]
        then
                echo "copying Cisco Anyconnect..."
		sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/Cisco_Anyconnect ~/Desktop
		chown -Rv local ~/Desktop/Cisco_Anyconnect
		CAC="T"
		echo "complete..."
        fi
        if [ "$VAR" = "Microsoft_Office_2016" ]
        then
                echo "copying Microsoft Office 2016..."
		sshpass -p "server password here" scp -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/Microsoft_Office_2016_Volume_Installer.pkg ~/Desktop
		chown -Rv local ~/Desktop/Office_2016.pkg
		MSO="T"
		echo "complete..."
        fi
        if [ "$VAR" = "Identity_Finder" ] 
        then
                echo "copying Identity Finder..."
		sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/Identity_Finder ~/Desktop
		chown -Rv local ~/Desktop/Identity_Finder
		IF="T"
		echo "complete..."
        fi
        if [ "$VAR" = "Mozilla_Firefox" ]
        then
                echo "copying Mozilla Firefox..."
		sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/Mozilla_Firefox ~/Desktop
		chown -Rv local ~/Desktop/Mozilla_Firefox
		MFF="T"
		echo "complete..."
        fi
	if [ "$VAR" = "Managed" ]
	then
		echo "copying Semantec Endpoint Protection (Managed)..."
		sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/SEP_12.1.6867.6400_Mac_Managed ~/Desktop
		chown -Rv local ~/Desktop/SEP_12.1.6867.6400_Mac_Managed
		SEPM="T"
		echo "complete..."
	fi
	if [ "$VAR" = "Unmanaged" ]
	then
		echo "copying Semantec Endpoint Protection (Unmanaged)..."
		sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/SEP_12.1.6867.6400_Mac_Unmanaged ~/Desktop
		chown -Rv local ~/Desktop/SEP_12.1.6867.6400_Mac_Unmanaged
		SEPU="T"
		echo "complete..."
	fi
		
done
echo "copying IBM Endpoint Management..."
sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/IBM_Endpoint_Management ~/Desktop
chown -Rv local ~/Desktop/IBM_Endpoint_Management
echo "complete..."
echo "copying Secunia CSI..."
sshpass -p "server password here" scp -r -o StrictHostKeyChecking=no macdeploy@144.92.28.54:/Users/macdeploy/Desktop/Secunia_CSI ~/Desktop
chown -Rv local ~/Desktop/Secunia_CSI
echo "complete..."
echo "---FILE COPY COMPLETE---"
echo "---BEGIN PACKAGE INSTALLS---"
if [ "$CPP" = "T" ]
then
	MOUNTDIR=$(echo `hdiutil mount CrashPlanPROe_Mac.dmg | tail -1 \
	| awk '{$1=$2=""; print $0}'` | xargs -0 echo) \
	&& installer -pkg "${MOUNTDIR}/"*.pkg -target /
fi
if [ "$ACC" = "T" ]
then 
	sudo installer -pkg AdobeCC_Mac_Design_22JUL2015/Build/Design_22JUL2015_Install.pkg -target /
fi
if [ "$CAC" = "T" ]
then
	sudo installer -pkg ~/Desktop/Cisco_Anyconnect/vpn.pkg -target /
fi
if [ "$MSO" = "T" ]
then
	sudo installer -pkg Microsoft_Office_2016_Volume_Installer.pkg -target /
fi	
if [ "$IF" = "T" ]
then
	sudo installer -pkg Identity_Finder/campus-console/IdentityFinder.pkg -target /
fi
if [ "$MFF" = "T" ]
then
	hdiutil mount Mozilla_Firefox/Firefox_47.0.dmg
fi
sudo installer -pkg IBM_Endpoint_Management/iem_client/BESAgent-9.2.7.53-BigFix_MacOSX10.6.pkg -target /
cd Secunia_CSI
cd OSX
sudo cp -R csia /Applications
cd
cd /Applications
ls
./csia -i -L
cd
cd Desktop
if [ "$SEPM" = "T" ]
then
	cd SEP_12.1.6867.6400_Mac_Managed/Additional_Resources
	sudo installer -pkg SEP.mpkg -target /
	cd
fi
if [ "$SEPU" = "T" ]
then
	cd SEP_12.1.6867.6400_Mac_Unmanaged/Additional_Resources
	sudo installer -pkg SEP.mpkg -target /
	cd
fi
cd
cd Desktop
say -v Bells "beep"
echo "---MANUALLY INSTALL FIREFOX---"
pause 'Press [Enter] to continue when finished...'
echo "---CLEANING UP---"
rm -R SEP_12.1.6867.6400_Mac_Unmanaged SEP_12.1.6867.6400_Mac_Managed Mozilla_Firefox AdobeCC_Mac_Design_22JUL2015 Cisco_Anyconnect IBM_Endpoint_Management Identity_Finder Secunia_CSI
rm -R CrashPlanPROe_Mac.dmg Microsoft_Office_2016_Volume_Installer.pkg
echo "done..."
echo "---------DON'T FORGET THIS NEXT STEP----------"
echo "Please make sure that the IP and MAC addresses and serial number of this machine are recorded in GLPI"
echo "Please RESTART THE MACHINE NOW and update Semantec during the next login..."
echo "---COMPLETE---"
