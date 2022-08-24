#!/usr/bin/env bash
CWD=$(pwd)
FILE="$CWD/list.txt"

ls *.svg > $FILE

while read -r LINE; do
	if [[ $LINE == *".svg"* ]]; then
        sed -i "s|stop-color:#ddd|stop-color:#000|g" ${LINE}
        sed -i "s|stop-color:#fff|stop-color:#666|g" ${LINE}
        sed -i "s|fill:#cccdce|fill:#999|g" ${LINE}
        sed -i "s|fill:#cccdce|fill:#999|g" ${LINE}
        sed -i "s|color:#000000;fill:#707073;|color:#000000;fill:#ffffff;|g" ${LINE}
        sed -i "s|fill:#707073;|fill:#ffffff;|g" ${LINE}
        sed -i "s|fill:#707073|fill:#ffffff;|g" ${LINE}
	fi
done < $FILE
