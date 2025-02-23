# Download-Tester.ps1
# Author: Daniel Keer
# Created: 2025-02-22
# Last Modified: 2025-02-22
# Version 1.0.0
#
# Description:
#   Performs a download test by downloading a file from a specified URL and measures the time it takes and removes the file after the test is complete.

# Parameters:
#   -ChangeProgPref: Switch to change the progress preference to "SilentlyContinue" before running the download test.
#    Default: False
#
#   -OutputPath <string>
#       The local file path where the downloaded file will be saved.
#       Default: "C:\temp\download-test-file.zip"
#
#   -DownloadUrl <string>
#       URL for the file to be downloaded for the download test.
#       Default: http://ipv4.download.thinkbroadband.com/512MB.zip
#
# Usage:
#   .\Download-Tester.ps1
#   .\Download-Tester.ps1 ChangeProgPref
#   .\Download-Tester.ps1 -OutputPath "D:\new-temp\test-file.zip"
#   .\Download-Tester.ps1 -DownloadUrl "http://ipv4.download.thinkbroadband.com/5MB.zip"


# set the defaults
  [CmdletBinding()]
  param (
  [string]$OutputPath = "C:\temp\download-test-file.zip",
  [string]$DownloadUrl = "http://ipv4.download.thinkbroadband.com/512MB.zip",
  [switch]$ChangeProgPref
  )


function download-tester{


#start the stopwatch before the download

 $stopwatch =  [system.diagnostics.stopwatch]::StartNew()

  write-host "Download is starting"
   try {
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $OutputPath -ErrorAction Stop
    } catch {
     write-host "An error occurred during the download: $_"
     exit 1
     }

#stop the stopwatch after the download
 $stopwatch.Stop()

#output the total time the download took
 write-host "Time it took" $stopwatch.Elapsed
}

# remove file function to remove the temp file
function remove-file {
 param (
 [string]$file
 )

  try {
   Remove-Item -Path $file -ErrorAction Stop
   Write-host "Removed file: $file"
   } catch {
   Write-host "Error removing file: $_"
   Exit 1
   }
  }


# output the version of PowerShell
Write-host "PowerShell Version is" $host.Version.ToString()


# Progress preference handling
# if ChangeProgPref switch is used alter ProgressPreference
if($ChangeProgPref.IsPresent){
 Write-host "Originally ProgressPreference was set to $ProgressPreference" -ForegroundColor Green

#store the original setting of ProgressPreference as OGProgressPreference
 $OGProgressPreference = $ProgressPreference

#set ProgressPreference to SilentlyContinue
 $ProgressPreference = 'SilentlyContinue'
 Write-host "Changed ProgressPreference to $ProgressPreference"

#run the download tester
download-tester

#restore the original setting of ProgressPreference
 $ProgressPreference = $OGProgressPreference
 Write-host "Restored ProgressPreference to $ProgressPreference" -ForegroundColor Green

#remove the downloaded file
 remove-file -file $OutputPath 

} else {

# if ChangeProgPref switch is not used then make no changes
  Write-host "ProgressPreference is currently $ProgressPreference" -ForegroundColor Green

#run the download tester
 download-tester

#remove the downloaded file
 remove-file -file $OutputPath
}
