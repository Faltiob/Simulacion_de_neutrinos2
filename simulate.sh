


rm -f *.txt results.txt performance.txt


for i in $(seq -w 1 1000); do
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    neutrinos=$((RANDOM % 11))  
    echo "$timestamp - Neutrinos detectados: $neutrinos" > $(printf "%04d.txt" $i)
done


cat *.txt > results.txt


total_diff=0
prev_time=0
count=0

for file in $(ls *.txt | sort); do
    time_str=$(head -n 1 "$file" | cut -d' ' -f1-2)
    timestamp=$(date -d "$time_str" +%s)
    if [ $prev_time -ne 0 ]; then
        diff=$((timestamp - prev_time))
        total_diff=$((total_diff + diff))
        count=$((count + 1))
    fi
    prev_time=$timestamp
done

if [ $count -eq 0 ]; then
    average=0
else
    average=$((total_diff / count))
fi

echo "Tiempo promedio entre eventos: $average segundos" > performance.txt
