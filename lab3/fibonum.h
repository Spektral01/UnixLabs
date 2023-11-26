#ifndef FIBONUM_H
#define FIBONUM_H

#include <QWidget>
#include <QPushButton>
#include <QListView>
#include <QMenuBar>
#include <QStatusBar>
#include <QMainWindow>
#include <QStringListModel>

class FibonacciWidget : public QMainWindow {
    Q_OBJECT

public:
    FibonacciWidget(QWidget *parent = nullptr);

private slots:
    void addFibonacciNumbers();

private:
    QWidget *centralWidget;
    QPushButton *pushButton;
    QListView *listView;
    QMenuBar *menuBar;
    QStatusBar *statusBar;
};

#endif // FIBONUM_H
