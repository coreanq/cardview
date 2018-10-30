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
#include <QTextCodec>

Speech::Speech(QObject *parent)
    : QObject(parent),
    m_speech(0)
{
    foreach (QString engine, QTextToSpeech::availableEngines()){
        qDebug() << "engine name" << engine;
		engineSelected(engine);
		break;
	}
    m_manager = new QNetworkAccessManager(this);
    connect(m_manager,SIGNAL(finished(QNetworkReply*)),this,SLOT(requestReceived(QNetworkReply*)));

#ifdef QT_DEBUG
    m_isDebug = true;
#else
    m_isDebug = false;
#endif
    
    auto textCodec = QTextCodec::codecForName("utf8");

    m_itemModel  =  textCodec->toUnicode(
                    "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                    "<root>"
                        "<item>"
                            "<name>kimchi cabbage</name>"
                            "<korean>배추</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>kimchi cabbage.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>water melon</name>"
                            "<korean>수박</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>water melon.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>pepper</name>"
                            "<korean>고추</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>pepper.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>pumpkin</name>"
                            "<korean>호박</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>pumpkin.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>cucumber</name>"
                            "<korean>오이</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>cucumber.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>paprika</name>"
                            "<korean>파프리카</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>paprika.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>tengerine</name>"
                            "<korean>귤</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>tengerine.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>mushroom</name>"
                            "<korean>버섯</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>mushroom.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>persimmon</name>"
                            "<korean>감</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>persimmon.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>peach</name>"
                            "<korean>복숭아</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>peach.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>strawberry</name>"
                            "<korean>딸기</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>strawberry.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>cherry</name>"
                            "<korean>체리</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>cherry.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>broccoli</name>"
                            "<korean>브로콜리</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>broccoli.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>lemon</name>"
                            "<korean>레몬</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>lemon.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>aubergine</name>"
                            "<korean>가지</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>aubergine.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>cabbage</name>"
                            "<korean>양배추</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>cabbage.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>pear</name>"
                            "<korean>배</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>pear.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>carrot</name>"
                            "<korean>당근</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>carrot.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>onion</name>"
                            "<korean>양파</korean>"
                            "<type>vegetabl</type>"
                            "<front_img_name>onion.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>blueberries</name>"
                            "<korean>블루베리</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>blueberries.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>kiwi</name>"
                            "<korean>키위</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>kiwi.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>sweet potato</name>"
                            "<korean>고구마</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>sweet potato.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>melon</name>"
                            "<korean>멜론</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>melon.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>grapefruit</name>"
                            "<korean>자몽</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>grapefruit.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>pomegranate</name>"
                            "<korean>석류</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>pomegranate.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>banana</name>"
                            "<korean>바나나</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>banana.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>apple</name>"
                            "<korean>사과</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>apple.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>tomato</name>"
                            "<korean>토마토</korean>"
                            "<type>vegetable</type>"
                            "<front_img_name>tomato.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>pineapple</name>"
                            "<korean>파인애플</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>pineapple.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>grape</name>"
                            "<korean>포도</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>grape.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                        "<item>"
                            "<name>orange</name>"
                            "<korean>오렌지</korean>"
                            "<type>fruit</type>"
                            "<front_img_name>orange.jpg</front_img_name>"
                            "<back_img_name>card_back.jpg</back_img_name>"
                        "</item>"
                  "</root>"
                  );
    
    qDebug() << m_itemModel;
    
}
QString Speech::itemModel()
{
    return m_itemModel;
}
void Speech::printModel()
{
    qDebug() << m_itemModel;
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
//        m_languageModel->appendRow(new QStandardItem(name) );
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
