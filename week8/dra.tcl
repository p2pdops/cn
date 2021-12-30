set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf
$ns rtproto DV
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam out.nam &
    exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n1 1Mb 0.01ms DropTail
$ns duplex-link $n1 $n2 1Mb 0.01ms DropTail
$ns duplex-link $n2 $n3 1Mb 0.01ms DropTail
$ns duplex-link $n3 $n0 1Mb 0.01ms DropTail

$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n1 $n2 orient down
$ns duplex-link-op $n2 $n3 orient left
$ns duplex-link-op $n3 $n0 orient up

set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp

set sink [new Agent/TCP/Sink]
$ns attach-agent $n2 $sink

$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP
$ftp set packet_size_ 100
$ftp set rate_ 1Mb

