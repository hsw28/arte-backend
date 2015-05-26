#!/bin/bash

#specify starting port for spike viewer in next line
port=5228

#specify starting port for LFP viewer in next line
portlfp=7000

./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 0"
wmctrl -r "Tetrode 0" -e 0,0,0,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 1"
wmctrl -r "Tetrode 1" -e 0,688,0,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 2"
wmctrl -r "Tetrode 2" -e 0,1300,0,600,300

#2nd row

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 3"
wmctrl -r "Tetrode 3" -e 0,0,380,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 4"
wmctrl -r "Tetrode 4" -e 0,688,380,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 5"
wmctrl -r "Tetrode 5" -e 0,1300,380,600,300

#3rd row
port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 6"
wmctrl -r "Tetrode 6" -e 0,0,715,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 7"
wmctrl -r "Tetrode 7" -e 0,688,715,600,300

#lfp viewer
./arteLfpViewer <<<$portlfp >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network LFP Viewer" -N "LFP Viewer 0-7"
wmctrl -r "LFP Viewer 0-7" -e 0,1300,715,600,300

#screen 2 row 1
port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 8"
wmctrl -r "Tetrode 8" -e 0,2000,0,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 9"
wmctrl -r "Tetrode 9" -e 0,2614,0,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 10"
wmctrl -r "Tetrode 10" -e 0,3228,0,600,300

#screen 2 2nd row

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 11"
wmctrl -r "Tetrode 11" -e 0,2000,380,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 12"
wmctrl -r "Tetrode 12" -e 0,2614,380,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 13"
wmctrl -r "Tetrode 13" -e 0,3228,380,600,300

#screen 2 row 3
port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 14"
wmctrl -r "Tetrode 14" -e 0,2000,715,600,300

port=$((port+1))
./arteSpikeViewer <<<$port >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network Spike Viewer" -N "Tetrode 15"
wmctrl -r "Tetrode 15" -e 0,2614,715,600,300

#lfp viewer
portlfp=$((port+1))
./arteLfpViewer <<<$portlfp >/dev/null 2>/dev/null &
sleep 1
wmctrl -r "Arte Network LFP Viewer" -N "LFP Viewer 8-15"
wmctrl -r "LFP Viewer 8-15" -e 0,3228,715,600,300

