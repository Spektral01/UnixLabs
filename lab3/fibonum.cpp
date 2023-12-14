#include "fibonum.h"

FibonacciWidget::FibonacciWidget(QWidget *parent) : QMainWindow(parent) {
    setGeometry(0, 0, 530, 545);
    setWindowTitle("MainWindow");

    centralWidget = new QWidget(this);

    pushButton = new QPushButton(centralWidget);
    pushButton->setGeometry(320, 10, 180, 40);
    pushButton->setText("Fibonacci Gen");

    listView = new QListView(centralWidget);
    listView->setGeometry(20, 10, 270, 490);
    listView->setVerticalScrollBarPolicy(Qt::ScrollBarAlwaysOn);

    setCentralWidget(centralWidget);

    menuBar = new QMenuBar(this);
    menuBar->setGeometry(0, 0, 530, 20);
    setMenuBar(menuBar);

    statusBar = new QStatusBar(this);
    setStatusBar(statusBar);

    connect(pushButton, SIGNAL(clicked()), this, SLOT(addFibonacciNumbers()));

    show();
}

void FibonacciWidget::addFibonacciNumbers() {
    QStringListModel *model = qobject_cast<QStringListModel*>(listView->model());

    if (!model) {
        model = new QStringListModel(this);
        listView->setModel(model);
    }

    QStringList dataList = model->stringList();

    int count = dataList.size();
    int first = (count > 0) ? dataList[count - 2].toInt() : 0;
    int second = (count > 1) ? dataList[count - 1].toInt() : 1;
    for (int i = 0; i < 45; ++i) {
        int next = first + second;
        dataList.append(QString::number(next));
        first = second;
        second = next;
    }

    model->setStringList(dataList);
}
