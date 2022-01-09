
set ns [new Simulator]
set tracefile [open trace.tr w]
set namtracefile [open out.nam w]
$ns trace-all $tracefile
$ns namtrace-all-wireless $namtracefile 500 400

proc finish {} {
    global ns tracefile namtracefile
    $ns flush-trace
    close $tracefile
    close $namtracefile
    exec nam out.nam 
    exit 0
}

create-god 5

set topo [new Topography]
$topo load_flatgrid 500 400

$ns node-config -adhocRouting DSDV \
 -llType LL \
 -macType Mac/802_11 \
 -ifqType Queue/DropTail/PriQueue \
 -ifqLen 300 \
 -antType Antenna/OmniAntenna \
 -propType Propagation/TwoRayGround \
 -phyType Phy/WirelessPhy \
 -channelType Channel/WirelessChannel  \
 -topoInstance $topo \
 -agentTrace ON \
 -routerTrace ON \
 -macTrace ON \
 -movementTrace ON
 
for {set i 0} {$i < 6} { incr i } {
    set n($i) [$ns node]
}

for {set i 0} {$i < 6} { incr i } {
    $n($i) set X_ [expr {round($i * 200.0)} % 600]
    $n($i) set Y_ [expr {($i / 3)*120} + 100 ]
    $n($i) set Z_ 0.0
}

$n(0) color Blue
$n(2) color Green
$n(4) color Red
$ns at 0.0 "$n(0) color Blue"
$ns at 0.0 "$n(2) color Green"
$ns at 0.0 "$n(0) label User"
$ns at 0.0 "$n(2) label User"

$ns at 0.0 "$n(4) color Red"
$ns at 0.0 "$n(4) label Server"

set udp0 [new Agent/UDP]
set udp1 [new Agent/UDP]
set sink0 [new Agent/LossMonitor] 
set sink1 [new Agent/LossMonitor] 
set cbr0 [new Application/Traffic/CBR]
set cbr1 [new Application/Traffic/CBR]

$ns attach-agent $n(4) $udp0
$ns attach-agent $n(4) $udp1
$ns attach-agent $n(0) $sink0
$ns attach-agent $n(2) $sink1
$ns connect $udp0 $sink0 
$ns connect $udp1 $sink1 
$cbr0 attach-agent $udp0 
$cbr1 attach-agent $udp1 
$ns at 0.5 "$cbr0 start"
$ns at 0.5 "$cbr1 start"
$ns at 3.0 "$cbr0 stop"
$ns at 3.0 "$cbr1 stop"

for {set i 0} {$i < 6} { incr i } {
    $ns initial_node_pos $n($i) 50
}

$ns at 10 "finish"
$ns run