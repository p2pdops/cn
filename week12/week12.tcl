set ns [new Simulator]
set namfile [open out.nam w]
$ns namtrace-all-wireless $namfile 500 500
set topo [new Topography]
$topo load_flatgrid 500 500
# create-god 6
set val(chan) Channel/WirelessChannel

$ns node-config -adhocRouting AODV-ll Type LL \
    -macType Mac/802_11 -ifqTypeQueue/DropTail/PriQueue \
    -ifqLen 50 -antTypeAntenna/OmniAntenna \
    -propType Propagation/TwoRayGround -phyTypePhy/WirelessPhy \
    -channel [new $val(chan)] -topoInstance $topo\
    -agentTrace ON -routerTrace OFF\
    -macTrace ON\
    -movementTrace OFF

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

$n0 random-motion 0
$n1 random-motion 0
$n2 random-motion 0
$n3 random-motion 0
$n4 random-motion 0
$n5 random-motion 0

$ns initial_node_pos $n0 20
$ns initial_node_pos $n1 20
$ns initial_node_pos $n2 20
$ns initial_node_pos $n3 20
$ns initial_node_pos $n4 20
$ns initial_node_pos $n5 50

$n0 set X_ 10.0
$n0 set Y_ 20.0
$n0 set Z_ 0.0

$n1 set X_ 210.0
$n1 set Y_ 230.0
$n1 set Z_ 0.0

$n2 set X_ 100.0
$n2 set Y_ 200.0
$n2 set Z_ 0.0

$n3 set X_ 150.0
$n3 set Y_ 230.0
$n3 set Z_ 0.0

$n4 set X_ 430.0
$n4 set Y_ 320.0
$n4 set Z_ 0.0

$n5 set X_ 270.0
$n5 set Y_ 120.0
$n5 set Z_ 0.0

$ns at 1.0 "$n1 set dest 490.0 340.0 25.0"
$ns at 1.0 "$n4 set dest 300.0 130.0 5.0"
$ns at 1.0 "$n5 set dest 190.0 440.0 15.0"
$ns at 5.0 "$n5 set dest 100.0 200.0 30.0"
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]

$ns attach-agent $n0 $tcp
$ns attach-agent $n5 $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ns at 1.0 "$ftp start";

set udp [ new Agent/UDP]
set null [ new Agent/Null]

$ns attach-agent $n2 $udp
$ns attach-agent $n3 $null
$ns connect $udp $null
set cbr [newApplication/Traffic/CBR]

$cbr attach-agent $udp
$ns at 1.0 "$cbr start"
$ns at 10.0 "finish"

proc finish {} {
    $ns flush-trace
    exec nam wireless.nam &
    exit 0
}

$ns run
