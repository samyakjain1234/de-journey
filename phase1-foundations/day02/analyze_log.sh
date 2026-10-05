#!/bin/bash
LOG="app.log"

echo "1. Total lines:"
wc -l < "$LOG"

echo "2. ERROR count:"
grep -c "ERROR" "$LOG"

echo "3. Requests per user (highest first):"
cut -d' ' -f4 "$LOG" | sort | uniq -c | sort -nr

echo "4. Average response time (ms):"
awk '{sum += $8} END {printf "%.2f\n", sum/NR}' "$LOG"

echo "5. Slowest request (user action ms):"
sort -k8 -nr "$LOG" | head -n 1 | awk '{print $4, $5, $8}'

echo "6. Unique IP addresses:"
cut -d' ' -f6 "$LOG" | sort -u | wc -l

echo "7. Requests with status 500:"
awk '$7 == 500' "$LOG" | wc -l
