#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtCore/QTextStream>
#include <QtCore/QFile>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QString waylandLog;
    if (app.arguments().size() < 2) {
        qDebug() << "Reading log from stdin";
        waylandLog = QTextStream(stdin).readAll();
    } else if (app.arguments().size() == 2) {
        QFile logFile(app.arguments().at(1));
        if (!logFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
            qCritical("Failed to open log file");
            return EXIT_FAILURE;
        }
        waylandLog = QTextStream(&logFile).readAll();
    }

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("waylandLog", waylandLog);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
