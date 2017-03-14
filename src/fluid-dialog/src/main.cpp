/*
 * This file is part of Liri Browser
 *
 * Copyright (C) 2017 Tim Süberkrüb <tim.sueberkrueb@web.de>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
*/

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QCommandLineParser>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QCommandLineParser cmdParser;
    cmdParser.setApplicationDescription("Fluid Dialog");
    cmdParser.addHelpOption();
    cmdParser.addPositionalArgument("title", "The dialog's title");
    cmdParser.addPositionalArgument("message", "The dialog's message");
    QCommandLineOption codeOption("code", "Optional code snippet to display", "snippet");
    cmdParser.addOption(codeOption);
    cmdParser.process(app);

    QStringList positionalArgs = cmdParser.positionalArguments();

    QString dialogTitle, dialogMessage, dialogCode;

    if (positionalArgs.length() < 2) {
        qWarning() << "Insufficent arguments.";
        return 1;
    }
    if (cmdParser.isSet(codeOption)) {
        dialogCode = cmdParser.value(codeOption);
    }

    dialogTitle = positionalArgs[0];
    dialogMessage = positionalArgs[1];

    QQuickStyle::setStyle(QLatin1String("Material"));

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("dialogTitle", dialogTitle);
    engine.rootContext()->setContextProperty("dialogMessage", dialogMessage);
    engine.rootContext()->setContextProperty("dialogCode", dialogCode);
    QObject::connect(&engine, &QQmlApplicationEngine::quit,
                     &app, &QGuiApplication::quit);
    engine.load(QUrl(QLatin1String("qrc:/ui/Main.qml")));

    return app.exec();
}
