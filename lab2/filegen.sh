#!/bin/bash -e

LOCKFILE="/_data/lockfile"

generate_filename(){
    exec 9>"$LOCKFILE"
    flock 9

    for i in {001..999}; do
        if [ ! -e "/_data/$i" ]; then
            echo "$i"
            break
        fi
    done
    
    flock -u 9
    exec 9>&-
}



while true; do
    filename=$(generate_filename)

    # Создание файла с идентификатором контейнера и порядковым номером
    echo "$(hostname) - $(date +%s)" > "/_data/$filename"

    sleep 1

    rm "/_data/$filename"

    sleep 1
done
