/*
 * Copyright (c) 2011-2013 BlackBerry Limited.
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
#include "UpFront.h"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>

#include <bb/ApplicationInfo>
#include <QSettings>

using namespace bb::cascades;

ApplicationUI::ApplicationUI(bb::cascades::Application *app) :
        QObject(app)
{
	// Initiator
	m_upFront = new UpFront(this);

    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    app->setScene(root);
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("Connect2UpFront_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

void ApplicationUI::updateUpFront(const QString backgroundZ, const QString backgroundQ, const QString icon, const QString message, const QString seconds, const QString t2w, const QString textColor, const QString other)
{
	// Send to UpFront, fill backgroundZ image (url), image (url), title, message, color (bb::cascades::Color)
	bb::ApplicationInfo appInfo;
	QString command = appInfo.signingHash() + "##" + appInfo.title() + "##" + backgroundZ + "##" + backgroundQ + "##" + icon + "##" + message + "##" + seconds + "##" + t2w + "##" + textColor + "##" + other;
	qDebug() << command;
	m_upFront->updateUpFront(command);
}

QString ApplicationUI::getValueFor(const QString key, const QString defaultValue)
{
    QSettings settings;
    return settings.value(key, defaultValue).toString();
}

void ApplicationUI::saveValueFor(const QString key, const QString value)
{
    QSettings settings;
    settings.setValue(key, value);
}
