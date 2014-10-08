/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/data/SqlDataAccess>
#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>

using namespace bb::cascades;

ApplicationUI::ApplicationUI() :
        QObject()
{
    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this,
            SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    QCoreApplication::setOrganizationName("NicolasHan");
    QCoreApplication::setApplicationName("NicoMeBB");

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);

    qml->setContextProperty("nicomeApp", this);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);


    //cover
    QmlDocument *qmlCover = QmlDocument::create("asset:///AppCover.qml").parent(
            this);

    if (!qmlCover->hasErrors()) {
        // Create the QML Container from using the QMLDocument.
        Container *coverContainer = qmlCover->createRootObject<Container>();

        // Create a SceneCover and set the application cover
        SceneCover *sceneCover = SceneCover::create().content(coverContainer);
        Application::instance()->setCover(sceneCover);
    }
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("NicomeBB_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

QString ApplicationUI::getValueFor(const QString &objectName, const QString &defaultValue)
{

    // If no value has been saved, return the default value.
    if (settings.value(objectName).isNull()) {
        return defaultValue;
    }

    // Otherwise, return the value stored in the settings object.
    return settings.value(objectName).toString();
}

void ApplicationUI::saveValueFor(const QString &objectName, const QString &inputValue)
{
    settings.setValue(objectName, QVariant(inputValue));
}

bool ApplicationUI::initDatabase(bool forceInit)
{
    QString srcDBPath = QDir::currentPath() + "/app/native/assets/" + "dbtemp/nicome.s3db";
    QString destDBPath = QDir::currentPath() + "/data/" + "nicome.s3db";

    if (QFile::exists(destDBPath)) {
        qDebug() << "database exist in data dir";
        if (forceInit) {
            QFile::remove(destDBPath);
            if (QFile::exists(destDBPath)) {
                qDebug() << "can't remove database in data dir";
            } else {
                qDebug() << "remove old database success";
            }
        }
    }

    if (QFile::copy(srcDBPath, destDBPath)) {
        return true;
    } else {
        return false;
    }
}

QUrl ApplicationUI::getDatabasePath()
{
    QString destDBPath = QDir::currentPath() + "/data/" + "nicome.s3db";
    return QUrl(destDBPath);
}

bool ApplicationUI::exportDbFile(const QString &exportTimeStamp)
{
    QString srcDBPath = QDir::currentPath() + "/data/" + "nicome.s3db";
    QString destDBPath = QDir::currentPath() + "/shared/documents/" + "nicome_backup_"
            + exportTimeStamp + ".s3db";

    if (QFile::copy(srcDBPath, destDBPath)) {
        return true;
    } else {
        return false;
    }

}

bool ApplicationUI::importDbFile(const QString &importFileName)
{
    QString srcDBPath = importFileName;
    QString destDBPath = QDir::currentPath() + "/data/" + "nicome.s3db";

    QFile::remove(destDBPath);

    if (QFile::copy(srcDBPath, destDBPath)) {
        return true;
    } else {
        return false;
    }
}

