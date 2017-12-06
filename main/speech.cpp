/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/


#include "speech.h"
#include <QDebug>
#include <QNetworkReply>

Speech::Speech(QObject *parent)
    : QObject(parent),
    m_speech(0), 
	m_languageModel(new QmlStandardItemModel() ),
	m_itemModel(new QmlStandardItemModel() )
{
    foreach (QString engine, QTextToSpeech::availableEngines()){
        qDebug() << "engine name" << engine;
		engineSelected(engine);
		break;
	}
    m_manager = new QNetworkAccessManager(this);
    connect(m_manager,SIGNAL(finished(QNetworkReply*)),this,SLOT(requestReceived(QNetworkReply*)));
    
    // qmlStandardItemdModel 의 경우 header 를 가지고 user role 을 생성함 
    QStringList headers;
    headers << "first" << "second";
    m_languageModel->setHorizontalHeaderLabels(headers);
    m_languageModel->applyRoles(); // model header to user role 
#if 0  
    ListModel {
        id: _itemModel
        ListElement {
            name: "사과"
            front_img_name: "apple.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name: "토마토"
            front_img_name: "tomato.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name: "파인애플"
            front_img_name: "pineapple.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name:"포도"
            front_img_name: "grape.jpg"
            back_img_name : "card_back.jpg"
        }
        ListElement {
            name: "오렌지"
            front_img_name: "orange.jpg"
            back_img_name : "card_back.jpg"
        }
    }
#endif
    headers << "name" << "front_img_name" << "back_img_name";
    m_itemModel->setHorizontalHeaderLabels(headers);
    m_itemModel->applyRoles(); // model header to user role 
    
    QList<QStandardItem*> items;
    
//    items << new QStandardItem("토마토") << new QStandardItem("tomato.jpg") << new QStandardItem("card_back.jpg");
//    m_itemModel->appendRow(items);
//    items.clear();
    
    
    items << new QStandardItem("사과") << new QStandardItem("apple.jpg") << new QStandardItem("card_back.jpg");
    m_itemModel->appendRow(items);
    items.clear();
    
    
    items << new QStandardItem("파인애플") << new QStandardItem("pineapple.jpg") << new QStandardItem("card_back.jpg");
    m_itemModel->appendRow(items);
    items.clear();
    
    items << new QStandardItem("포도") << new QStandardItem("grape.jpg") << new QStandardItem("card_back.jpg");
    m_itemModel->appendRow(items);
    items.clear();
    
    items << new QStandardItem("오렌지") << new QStandardItem("orange.jpg") << new QStandardItem("card_back.jpg");
    m_itemModel->appendRow(items);
    items.clear();
}
QmlStandardItemModel* Speech::languageModel()
{
    return m_languageModel;
}
QmlStandardItemModel* Speech::itemModel()
{
    return m_itemModel;
}
void Speech::requestGet()
{
    qDebug() << Q_FUNC_INFO;
    m_manager->get(QNetworkRequest(QUrl("http://edu-card.herokuapp.com/cards")));
}
void Speech::requestReceived(QNetworkReply *reply)
{
    reply->deleteLater();

    if(reply->error() == QNetworkReply::NoError) {
        // Get the http status code
        int v = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
        if (v >= 200 && v < 300) // Success
        {
             // Here we got the final reply 
            QString replyText = reply->readAll();
            qDebug() << Q_FUNC_INFO << replyText;
            emit dataRecved(replyText);
        } 
        else if (v >= 300 && v < 400) // Redirection
        {
            // Get the redirection url
            QUrl newUrl = reply->attribute(QNetworkRequest::RedirectionTargetAttribute).toUrl();
            // Because the redirection url can be relative, 
            // we have to use the previous one to resolve it 
            newUrl = reply->url().resolved(newUrl);

            QNetworkAccessManager *manager = reply->manager();
            QNetworkRequest redirection(newUrl);
            QNetworkReply *newReply = manager->get(redirection);

            return; // to keep the manager for the next request
        } 
    } 
    else 
    {
        // Error
        qDebug() << Q_FUNC_INFO;
    }

    reply->manager()->deleteLater();
}
void Speech::speak(QString sentence)
{
    qDebug() << Q_FUNC_INFO;
    m_speech->say(sentence);
}
void Speech::stop()
{
    m_speech->stop();
}

void Speech::setRate(int rate)
{
    m_speech->setRate(rate / 10.0);
}

void Speech::setPitch(int pitch)
{
    m_speech->setPitch(pitch / 10.0);
}

void Speech::setVolume(int volume)
{
    m_speech->setVolume(volume / 100.0);
}

void Speech::stateChanged(QTextToSpeech::State state)
{
//    if (state == QTextToSpeech::Speaking) {
//        ui.statusbar->showMessage("Speech started...");
//    } else if (state == QTextToSpeech::Ready)
//        ui.statusbar->showMessage("Speech stopped...", 2000);
//    else if (state == QTextToSpeech::Paused)
//        ui.statusbar->showMessage("Speech paused...");
//    else
//        ui.statusbar->showMessage("Speech error!");

//    ui.pauseButton->setEnabled(state == QTextToSpeech::Speaking);
//    ui.resumeButton->setEnabled(state == QTextToSpeech::Paused);
//    ui.stopButton->setEnabled(state == QTextToSpeech::Speaking || state == QTextToSpeech::Paused);
}

void Speech::engineSelected(QString engineName)
{
//    QString engineName = ui.engine->itemData(index).toString();
//    delete m_speech;
    if (engineName == "default")
        m_speech = new QTextToSpeech(this);
    else
        m_speech = new QTextToSpeech(engineName, this);
    // Populate the languages combobox before connecting its signal.
    QVector<QLocale> locales = m_speech->availableLocales();
    QLocale current = m_speech->locale();
    foreach (const QLocale &locale, locales) {
        QString name(QString("%1 (%2)")
                     .arg(QLocale::languageToString(locale.language()))
                     .arg(QLocale::countryToString(locale.country())));
//        QVariant localeVariant(locale);
        m_languageModel->appendRow(new QStandardItem(name) );
        qDebug() << name;
//        ui.language->addItem(name, localeVariant);
//        if (locale.name() == current.name())
//            current = locale;
    }
    emit languageModelChanged();

//    connect(m_speech, &QTextToSpeech::stateChanged, this, &Speech::stateChanged);
//    connect(m_speech, &QTextToSpeech::localeChanged, this, &Speech::localeChanged);

//    connect(ui.language, static_cast<void (QComboBox::*)(int)>(&QComboBox::currentIndexChanged), this, &Speech::languageSelected);
    localeChanged(current);
}

void Speech::languageSelected(int language)
{
//    QLocale locale = ui.language->itemData(language).toLocale();
//    m_speech->setLocale(locale);
}

void Speech::voiceSelected(int index)
{
    m_speech->setVoice(m_voices.at(index));
}

void Speech::localeChanged(const QLocale &locale)
{
//    QVariant localeVariant(locale);
//    ui.language->setCurrentIndex(ui.language->findData(localeVariant));

//    disconnect(ui.voice, static_cast<void (QComboBox::*)(int)>(&QComboBox::currentIndexChanged), this, &Speech::voiceSelected);
//    ui.voice->clear();

    m_voices = m_speech->availableVoices();
    QVoice currentVoice = m_speech->voice();
    foreach (const QVoice &voice, m_voices) {
        qDebug() << (QString("%1 - %2 - %3").arg(voice.name())
                          .arg(QVoice::genderName(voice.gender()))
                          .arg(QVoice::ageName(voice.age())));
    }
//    connect(ui.voice, static_cast<void (QComboBox::*)(int)>(&QComboBox::currentIndexChanged), this, &Speech::voiceSelected);
}
