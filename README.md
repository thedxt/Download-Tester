# Download-Tester.ps1
A PowerShell script that preforms a downlaod test by downloading a file from a specified URL and measures the time it takes and removes the file after the test is complete.

## Parameters

- `-ChangeProgPref` Switch to change the progress preference to "SilentlyContinue" before running the download test.
  - Default: False
- `-OutputPath` The local file path where the downloaded file will be saved.
  -  Default: `C:\temp\download-test-file.zip`
- `-DownloadUrl` URL for the file to be downloaded for the download test.
  - Default: `http://ipv4.download.thinkbroadband.com/512MB.zip`

[More detailed documentation](https://thedxt.ca/)
