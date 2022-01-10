set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf

$ns color 1 Blue

proc finish {} {
	global ns nf
	$ns flush-trace
	close $nf
	exec nam out.nam &
	exit 0
}


set n0 [$ns node]
set n1 [$ns node]
$ns at 0.0 "$n0 label \"Sender\" "
$ns at 0.0 "$n1 label \"Receiver\" "

$ns duplex-link $n0 $n1 1Mb 200ms DropTail
$ns duplex-link-op $n0 $n1 orient right

set tcp [new Agent/TCP]
set tcpsink [new Agent/TCPSink]
$ns attach-agent $n0 $tcp
$ns attach-agent $n1 $tcpsink
$ns connect $tcp $tcpsink

$tcp set fid_ 1
$tcp set window_ 1
$tcp set maxcwnd_ 1

$ns add-agent-trace $tcp tcp
$ns monitor-agent-trace $tcp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 0.5 "$ftp start"
$ns at 3.0 "$ns detach-agent $n0 $tcp ; $ns detach-agent $n1 $tcpsink "
$ns at 1.0 "$ns trace-annotate \"send packet 1\""
$ns at 1.4 "$ns trace-annotate \"recieve ack 1\""
$ns at 2.0 "$ns trace-annotate \"send packet 2\""
$ns at 2.5 "$ns trace-annotate \"receive ack 2\""
$ns at 3.2 "$ns trace-annotate \"send packet 3\""
$ns at 3.5 "$ns trace-annotate \"receive ack 3\""
$ns at 3.8 "$ns trace-annotate \"send packet 4\""
$ns at 4.0 "finish"
$ns run