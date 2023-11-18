#!/bin/bash -e


generate_filename(){
    for i in {001..999}; do
        if [ ! -e "/temp_files/$i" ]; then
            echo "$i"
            break
        fi
    done
}

while true; do
    # Блокировка для определения незанятого имени файла
    exec 9>/tmp/lockfile
    flock -n 9 || continue

    filename=$(generate_filename)

    # Разблокировка
    flock -u 9
    exec 9>&-

    # Создание файла с идентификатором контейнера и порядковым номером
    echo "$(hostname) - $(date +%s)" > "/temp_files/$filename"

    sleep 1

    rm "/temp_files/$filename"

    sleep 1
done
