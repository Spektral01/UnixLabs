#include <QApplication>
#include "fibonum.h"  // Включаем заголовочный файл с объявлением класса FibonacciWidget

int main(int argc, char *argv[]) {
    QApplication app(argc, argv);
    FibonacciWidget fibWidget;
    return app.exec();
}
