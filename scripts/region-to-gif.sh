#!/bin/sh

byzanz-record $(xrectsel "--x=%x --y=%y --width=%w --height=%h") out.gif && notification.sh -t "Finished recording"
