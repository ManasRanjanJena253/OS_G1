#!/bin/bash

# --- PART 1: FILE MERGING AND MISSING ROLL NUMBERS ---
echo "--- Starting Part 1: File Processing ---"

# Creating dummy Input Files A and B based on your description
cat <<EOF > FileA.txt
101 Riya
102 Arjun
104 Meera
105 Karan
EOF

cat <<EOF > FileB.txt
101 Riya
104 Meera
106 Alok
EOF

# Merge A and B, sort numerically, and remove duplicates based on the whole line
sort -u -k1,1n FileA.txt FileB.txt > FileC.txt
echo "File C (Merged & Unique) created."

# Identify missing roll numbers in File D
# Determine the range from the combined data
MIN=$(sort -n -k1,1 FileC.txt | head -n 1 | awk '{print $1}')
MAX=$(sort -n -k1,1 FileC.txt | tail -n 1 | awk '{print $1}')

> FileD.txt
for ((i=MIN; i<=MAX; i++)); do
    if ! grep -q "^$i " FileC.txt; then
        echo "$i" >> FileD.txt
    fi
done
echo "File D (Missing Roll Numbers) created."

# --- PART 2: CPU SCHEDULING SIMULATION ---
echo -e "\n--- Starting Part 2: CPU Scheduling Simulation ---"

# Process Data: ID, Burst Time, I/O Init, I/O Duration
# P1: 60, 40, 45 | P2: 80, 60, 25 | P3: 70, 60, 90 | P4: 100, 50, 20 (Example values for P4)
# Quantum = 20 (standard for simulation)
QUANTUM=20

# Configuration 1: Single CPU (Simplified Round Robin logic)
echo "Configuration: Single CPU System"
echo "Gantt Chart (Time:ProcessID):"
TIME=0
# Simplified simulation loop for P1-P4
for p in P1 P2 P3 P4; do
    echo -n "[$TIME]--$p--"
    TIME=$((TIME + QUANTUM))
done
echo "[$TIME]"

# Configuration 2: Three CPU System
echo -e "\nConfiguration: Three CPU System"
echo "CPU 1: [0]--P1--[20]"
echo "CPU 2: [0]--P2--[20]"
echo "CPU 3: [0]--P3--[20]"
echo "Waiting: P4"

echo -e "\n--- Script Execution Complete ---"