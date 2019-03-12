(
	choco --version || "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
) && ((net start | findstr "4  RUNNNING") && ( (netstat -b -a | find "51222" ) || (
	sc stop sshd
	sc delete sshd
	choco uninstall openssh -y
))
(	
	choco install openssh -y -params "/SSHServerFeature /SSHServerPort:51222"
	choco install saltminion -y --params "/master=10.0.0.95"
))