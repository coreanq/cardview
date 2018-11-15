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
#include <QStringList>

Speech::Speech(QObject *parent)
    : QObject(parent),
    m_speech(0)
{

#ifdef QT_DEBUG
    m_isDebug = true;
#else
    m_isDebug = false;
#endif

    m_fruitList << QString::fromUtf8("kimchi cabbage,vegetable,배추");
    m_fruitList << QString::fromUtf8("water melon,vegetable,수박");
    m_fruitList << QString::fromUtf8("pepper,vegetable,고추");
    m_fruitList << QString::fromUtf8("pumpkin,vegetable,호박");
    m_fruitList << QString::fromUtf8("cucumber,vegetable,오이");
    m_fruitList << QString::fromUtf8("paprika,vegetable,파프리카");
    m_fruitList << QString::fromUtf8("tengerine,vegetable,귤");
    m_fruitList << QString::fromUtf8("mushroom,vegetable,버섯");
    m_fruitList << QString::fromUtf8("persimmon,vegetable,감");
    m_fruitList << QString::fromUtf8("peach,vegetable,복숭아");
    m_fruitList << QString::fromUtf8("cherry,vegetable,체리");
    m_fruitList << QString::fromUtf8("broccoli,vegetable,브로콜리");
    m_fruitList << QString::fromUtf8("lemon,vegetable,레몬");
    m_fruitList << QString::fromUtf8("aubergine,vegetable,가지");
    m_fruitList << QString::fromUtf8("cabbage,vegetable,양배추");
    m_fruitList << QString::fromUtf8("pear,vegetable,배");
    m_fruitList << QString::fromUtf8("carrot,vegetable,당근");
    m_fruitList << QString::fromUtf8("onion,vegetable,양파");
    m_fruitList << QString::fromUtf8("blueberries,vegetable,블루베리");
    m_fruitList << QString::fromUtf8("kiwi,vegetable,키위");
    m_fruitList << QString::fromUtf8("sweet potato,vegetable,고구마");
    m_fruitList << QString::fromUtf8("melon,vegetable,멜론");
    m_fruitList << QString::fromUtf8("grapefruit,vegetable,자몽");
    m_fruitList << QString::fromUtf8("pomegranate,vegetable,석류");
    m_fruitList << QString::fromUtf8("banana,vegetable,바나나");
    m_fruitList << QString::fromUtf8("apple,vegetable,사과");
    m_fruitList << QString::fromUtf8("tomato,vegetable,토마토");
    m_fruitList << QString::fromUtf8("pineapple,vegetable,파인애플");
    m_fruitList << QString::fromUtf8("grape,vegetable,포도");
    m_fruitList << QString::fromUtf8("orange,vegetable,오렌지");

}
void Speech::updateModels()
{
    foreach (QString engine, QTextToSpeech::availableEngines()){
        qDebug() << "engine name" << engine;
        engineSelected(engine);
        break;
    }
    // jsobject
    auto elementTemplate = QString("{ \"name\" : \"%1\", \"english\" : \"%1\", \"front_img_name\" : \"%1.jpg\", \"type\" : \"%2\", \"korean\" : \"%3\"}");
    foreach (QString item, m_fruitList){
        auto itemSplit = item.split(",", QString::SkipEmptyParts);
        auto element = elementTemplate
                .arg(itemSplit.at(0).trimmed())
                .arg(itemSplit.at(1).trimmed())
                .arg(itemSplit.at(2).trimmed());
        emit elementAdded(element, "vegetable");
    }
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

    QVector<QLocale> locales = m_speech->availableLocales();
    QLocale current = m_speech->locale();
    foreach (const QLocale &locale, locales) {
        QString name(QString("%1")
                     .arg(QLocale::languageToString(locale.language())) );
                     .arg(QLocale::countryToString(locale.country())));
        emit voiceLanguageAdded(QString("{\"language\": \"%1\"}").arg(name));
        m_voiceLanguageList.append(name);
        qDebug() << name;
    }

//    connect(m_speech, &QTextToSpeech::stateChanged, this, &Speech::stateChanged);
    connect(m_speech, &QTextToSpeech::localeChanged, this, &Speech::localeChanged);

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
    emit voiceTypeUpdate();
    m_voiceTypeList.clear();

    m_voices = m_speech->availableVoices();
    QVoice currentVoice = m_speech->voice();
    foreach (const QVoice &voice, m_voices) {
        auto voiceType = (QString("%1 - %2 - %3").arg(voice.name())
                          .arg(QVoice::genderName(voice.gender()))
                          .arg(QVoice::ageName(voice.age())));

        m_voiceTypeList.append(voiceType);
        qDebug() << voiceType;
        emit voiceTypeAdded(QString("{\"voiceType\": \"%1\"}").arg(voiceType));
    }
//    connect(ui.voice, static_cast<void (QComboBox::*)(int)>(&QComboBox::currentIndexChanged), this, &Speech::voiceSelected);
}
