#include <QApplication>
#include <QMainWindow>

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);
    QMainWindow win;
    win.show();
    return app.exec();
}

