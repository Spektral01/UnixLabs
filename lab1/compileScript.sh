#!/bin/sh

# Проверка наличия аргумента
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <source_file>"
    exit 1
fi

SOURCE_FILE="$1"
TEMP_DIR=$(mktemp -d)

# Обработка сигналов для удаления временного каталога
trap 'rm -rf "$TEMP_DIR"' HUP INT QUIT PIPE TERM EXIT

# Проверка наличия файла и доступа
if [ ! -f "$SOURCE_FILE" ] || [ ! -r "$SOURCE_FILE" ]; then
    echo "Error: Cannot read the source file or file does not exist."
    exit 2
fi

# Извлечение имени выходного файла из комментария &Output: в компилируемом файле
OUTPUT_FILE=$(grep -o "&Output:[[:space:]]*[a-zA-Z0-9_]*\.txt" "$SOURCE_FILE" | awk '{print $2}')

# Имя выходного файла не найдено, ошибка
if [ -z "$OUTPUT_FILE" ]; then
    echo "Error: Output file name not specified in source."
    exit 3
fi

# Компиляция cpp
if [ "${SOURCE_FILE##*.}" = "cpp" ]; then
    g++ "$SOURCE_FILE" -o "$TEMP_DIR/$OUTPUT_FILE"
else
    echo "Error: Unsupported file type."
    exit 4
fi

# Если компиляция не удалась, завершить с ошибкой
if [ $? -ne 0 ]; then
    echo "Error: Compilation failed."
    exit 5
fi

# Переместить результирующий файл рядом с исходным файлом
mv "$TEMP_DIR/$OUTPUT_FILE" "$(dirname "$SOURCE_FILE")/$OUTPUT_FILE"

echo "Compilation succeeded. Output: $(dirname "$SOURCE_FILE")/$OUTPUT_FILE"
