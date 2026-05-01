#!/usr/bin/env bash

# General Idea for this script is the following

#-Direct to folder containing web files
#cd ~/Documents/coding/projects/personal-portfolio-website/

#-Use Python to create a local server on host machine
#python3 -m http.server 8000

#-Open run the server in host machine browser
#http://localhost:8000


# Configure port and location of server persistence
PORT=8000
DIR="$HOME/Documents/coding/projects/personal-portfolio-website/src"

# Move to project directory
cd "$DIR" || { echo "Failed to enter directory"; exit 1;}

# Start server in background
python3 -m http.server "$PORT" & SERVER_PID=$!

echo "Server started on http://localhost:#PORT (PID: $SERVER_PID)"

# Clean up function
cleanup() {
	echo ""
	echo "Stopping server..."
	kill "$SERVER_PID" 2>/dev/null
	wait "$SERVER_PID" 2>/dev/null
	echo "Server stopped."
}

# Reduce exit feed
trap cleanup EXIT INT TERM

# Let server warm up
sleep 1

# Open in host machine browser
xdg-open "http://localhost:$PORT" >/dev/null 2>&1

# Keep script running
wait "$SERVER_PID"
