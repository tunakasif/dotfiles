Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
# Import-Module 'C:\dev\vcpkg\scripts\posh-vcpkg'
# Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
Import-Module posh-git
Import-Module Posh-SSH
# Set-PoshPrompt -Theme ~/.go-my-posh.json
Invoke-Expression (&starship init powershell)


function cdgh { set-location "~\repos" };
function cdcc { set-location "~\Google Drive\school\MS" };
function cdd { set-location "~\Desktop" };
function pwshconfig { vim "~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" };
function vimconfig { vim "~\.vimrc" };
function fm { lf };
function fml {
  lf -last-dir-path "C:\Users\tunak\.lfdir\last_dir";
  $LASTDIR = (cat ~\.lfdir\last_dir);
  cd $LASTDIR
};
# function fml { lf -last-dir-path ~\.lfdir\last_dir; $LASTDIR = (cat ~\.lfdir\last_dir); echo $LASTDIR };
function sudo { powershell.exe Start-Process -Verb RunAs wt };

