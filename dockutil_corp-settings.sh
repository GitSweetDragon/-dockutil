#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# version 1.0
# Written by: GitSweetDragon
#
# Permission is granted to use this code in any way you want.
# Credit would be nice, but not obligatory.
# Provided "as is", without warranty of any kind, express or implied.
#
# DESCRIPTION
# This script configures users docks using docktutil
# source dockutil https://github.com/kcrawford/dockutil/
# 
# REQUIREMENTS
# dockutil Version 3.0.2 or higher installed to /usr/local/bin/
# Compatible with macOS 12.x and higher on M1
# Compatible with Jamf Pro Cloud version 10.42
#
# Note : 
# Set your own url text on line 79 & 80 
# Set your own onedrive text on line 92 "Onedrive-corp/' --label 'Corp-OneDrive'

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 



#We need to wait for the dock to actually start
until [[ $(pgrep Dock) ]]; do
    wait
done

#Set variables
dockutil="/usr/local/bin/dockutil"

#loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )


#Get the current logged in user that we'll be modifying
user=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

userHome="/Users/$user"
#path to plist
plist="${userHome}/Library/Preferences/com.apple.dock.plist"

#remove base items to the dock    
dockutil --remove '/System/Applications/System Preferences.app' --allhomes --no-restart	
dockutil --remove '/System/Applications/Launchpad.app' --allhomes --no-restart
dockutil --remove '/System/Applications/Safari.app' --allhomes --no-restart	
dockutil --remove '/System/Applications/Messages.app' --allhomes --no-restart	
dockutil --remove '/System/Applications/Mail.app' --allhomes --no-restart	
dockutil --remove '/System/Applications/Maps.app' --allhomes --no-restart	  
dockutil --remove '/System/Applications/Photos.app' --allhomes --no-restart
dockutil --remove '/System/Applications/FaceTime.app' --allhomes --no-restart
dockutil --remove '/System/Applications/Calendar.app' --allhomes --no-restart	
dockutil --remove '/System/Applications/Contacts.app'  --allhomes --no-restart	
dockutil --remove '/System/Applications/Reminders.app' --allhomes --no-restart
dockutil --remove '/System/Applications/Notes.app' --allhomes --no-restart
dockutil --remove '/System/Applications/TV.app' --allhomes --no-restarts
dockutil --remove '/System/Applications/Music.app' --allhomes --no-restart
dockutil --remove '/System/Applications/Podcasts.app' --allhomes --no-restart
dockutil --remove '/System/Applications/Keynote.app' --allhomes --no-restart
dockutil --remove '/System/Applications/Numbers.app' --allhomes --no-restart
dockutil --remove '/System/Applications/Pages.app' --allhomes --no-restart
dockutil --remove '/System/Applications/App Store.app' --allhomes --no-restart

#Remove all items for logged in user
dockutil --remove all --allhomes --no-restart

#Adding base items to the dock    
dockutil --add '/System/Applications/System Preferences.app' --position 1 --allhomes --no-restart	
dockutil --add '/Applications/DisplayLink Manager.app' --position 2 --allhomes --no-restart
dockutil --add '/System/Applications/Calculator.app' --position 3 --allhomes --no-restart
dockutil --add '/System/Applications/Utilities/Screenshot.app' --position 4 --allhomes --no-restart
dockutil --add '/Applications/Self Service.app' --position 5 --allhomes --no-restart
dockutil --add '/Applications/Safari.app' --position 6 --allhomes --no-restart
dockutil --add '/Applications/Google Chrome.app' --position 7 --allhomes --no-restart
dockutil --add  https://intra.corp.fr --label 'Corp intra' --position 8 --section apps --allhomes --no-restart
dockutil --add  https://www.corp.com --label 'Corp' --section apps --position 9 --allhomes --no-restart 
dockutil --add '/Applications/Microsoft Teams.app' --position 10 --allhomes --no-restart
dockutil --add '/Applications/Microsoft Outlook.app' --after 'Microsoft Teams' --allhomes --no-restart
dockutil --add '/Applications/Microsoft Word.app' --after 'Microsoft Outlook' --allhomes --no-restart
dockutil --add '/Applications/Microsoft Excel.app' --after 'Microsoft Word' --allhomes --no-restart
dockutil --add '/Applications/Microsoft PowerPoint.app' --after 'Microsoft Excel' --allhomes --no-restart

#Add folder
dockutil --add '/Users/'$user'/' --view grid --display folder --sort name --section others --position last --no-restart --allhomes
dockutil --add '/Applications' --view grid --display folder --sort name --section others --position last --no-restart --allhomes
dockutil --add '/Users/'$user'/Desktop/'  --label 'Bureau' --view grid --display folder --sort name --section others --position last --no-restart --allhomes
dockutil --add '/Users/'$user'/Documents/' --label 'Documents' --view grid --display folder --sort name --section others --position last --no-restart --allhomes
dockutil --add '/Users/'$user'/Library/CloudStorage/Onedrive-corp/' --label 'Corp-OneDrive' --view grid --display folder --sort name --section others --position last --no-restart --allhomes
dockutil --add '/Users/'$user'/Downloads/' --label 'Téléchargement' --view grid --display folder --sort dateadded --section others --position last --no-restart --allhomes

killall Dock

exit 0
