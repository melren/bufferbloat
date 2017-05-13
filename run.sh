#!/bin/bash

# Note: Mininet must be run as root.  So invoke this shell script
# using sudo.

time=200
bwnet=1.5
bw=1000
# TODO: If you want the RTT to be 20ms what should the delay on each
# link be?  Set this value correctly.
delay=5

iperf_port=5001

# Clean out mininet prior to run in case previous run crashed.
mn -c

for qsize in 20 100; do
    dir=bb-q$qsize

    # TODO: Run bufferbloat.py here...
    python bufferbloat.py -B $bw -b $bwnet --delay $delay -d $dir --maxq $qsize -t $time

    # TODO: Ensure the input file names match the ones you use in
    # bufferbloat.py script.  Also ensure the plot file names match
    # the required naming convention when submitting your tarball.
    python plot_tcpprobe.py -f $dir/cwnd.txt -o cwnd-q$qsize.png -p $iperf_port
    python plot_queue.py -f $dir/q.txt -o buffer-q$qsize.png
    python plot_ping.py -f $dir/ping.txt -o rtt-q$qsize.png
done
