#!/bin/bash

cat <<EOL > access.log
192.168.1.1 - - [28/Jul/2024:12:34:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.2 - - [28/Jul/2024:12:35:56 +0000] "POST /login HTTP/1.1" 200 567
192.168.1.3 - - [28/Jul/2024:12:36:56 +0000] "GET /home HTTP/1.1" 404 890
192.168.1.1 - - [28/Jul/2024:12:37:56 +0000] "GET /index.html HTTP/1.1" 200 1234
192.168.1.4 - - [28/Jul/2024:12:38:56 +0000] "GET /about HTTP/1.1" 200 432
192.168.1.2 - - [28/Jul/2024:12:39:56 +0000] "GET /index.html HTTP/1.1" 200 1234
EOL


echo "Отчет о логе веб-сервера" > report.txt

echo "-------------------------" >> report.txt
echo "-------------------------" >> report.txt

total_requests=$(wc -l < access.log)
echo "Общее количество запросов: $total_requests" >> report.txt

unique_ips=$(awk '{print $1}' access.log | sort | uniq | wc -l)
echo "Количество уникальных IP-адресов: $unique_ips" >> report.txt

echo "Количество запросов по методам:" >> report.txt
awk '{print $6}' access.log | cut -d'"' -f2 | sort | uniq -c | awk '{print $2 " " $1}' >> report.txt

most_popular_url=$(awk '{print $7}' access.log | sort | uniq -c | sort -nr | head -n 1 | awk '{print $1 " " $2}')
echo "Самый популярный URL: $most_popular_url" >> report.txt
