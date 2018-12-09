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
#include <QJsonValue>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>

Speech::Speech(QObject *parent)
    : QObject(parent),
    m_speech(0),
    m_rate(0),
    m_pitch(-4)
{

#ifdef QT_DEBUG
    m_isDebug = true;
#else
    m_isDebug = false;
#endif


    auto fruitList = QStringList();
    fruitList << QString::fromUtf8("kimchi cabbage,vegetable,배추");
    fruitList << QString::fromUtf8("water melon,vegetable,수박");
    fruitList << QString::fromUtf8("pepper,vegetable,고추");
    fruitList << QString::fromUtf8("pumpkin,vegetable,호박");
    fruitList << QString::fromUtf8("cucumber,vegetable,오이");
    fruitList << QString::fromUtf8("paprika,vegetable,파프리카");
    fruitList << QString::fromUtf8("tengerine,vegetable,귤");
    fruitList << QString::fromUtf8("mushroom,vegetable,버섯");
    fruitList << QString::fromUtf8("persimmon,vegetable,감");
    fruitList << QString::fromUtf8("peach,vegetable,복숭아");
    fruitList << QString::fromUtf8("cherry,vegetable,체리");
    fruitList << QString::fromUtf8("broccoli,vegetable,브로콜리");
    fruitList << QString::fromUtf8("lemon,vegetable,레몬");
    fruitList << QString::fromUtf8("aubergine,vegetable,가지");
    fruitList << QString::fromUtf8("cabbage,vegetable,양배추");
    fruitList << QString::fromUtf8("pear,vegetable,배");
    fruitList << QString::fromUtf8("carrot,vegetable,당근");
    fruitList << QString::fromUtf8("onion,vegetable,양파");
    fruitList << QString::fromUtf8("blueberries,vegetable,블루베리");
    fruitList << QString::fromUtf8("kiwi,vegetable,키위");
    fruitList << QString::fromUtf8("sweet potato,vegetable,고구마");
    fruitList << QString::fromUtf8("melon,vegetable,멜론");
    fruitList << QString::fromUtf8("grapefruit,vegetable,자몽");
    fruitList << QString::fromUtf8("pomegranate,vegetable,석류");
    fruitList << QString::fromUtf8("banana,vegetable,바나나");
    fruitList << QString::fromUtf8("apple,vegetable,사과");
    fruitList << QString::fromUtf8("tomato,vegetable,토마토");
    fruitList << QString::fromUtf8("pineapple,vegetable,파인애플");
    fruitList << QString::fromUtf8("grape,vegetable,포도");
    fruitList << QString::fromUtf8("orange,vegetable,오렌지");

    fruitList << QString::fromUtf8("dog,animal,강아지");
    fruitList << QString::fromUtf8("frog,animal,개구리");
    fruitList << QString::fromUtf8("rabbit,animal,토끼");
    fruitList << QString::fromUtf8("pig,animal,돼지");
    fruitList << QString::fromUtf8("lion,animal,사자");
    fruitList << QString::fromUtf8("sheep,animal,양");
    fruitList << QString::fromUtf8("whale,animal,고래");
    fruitList << QString::fromUtf8("cat,animal,고양이");
    fruitList << QString::fromUtf8("snake,animal,뱀");
    fruitList << QString::fromUtf8("goose,animal,거위");
    //fruitList << QString::fromUtf8("cow,animal,소");
    fruitList << QString::fromUtf8("deer,animal,사슴");
    fruitList << QString::fromUtf8("horse,animal,말");
    fruitList << QString::fromUtf8("donkey,animal,당나귀");
    fruitList << QString::fromUtf8("camel,animal,낙타");
    fruitList << QString::fromUtf8("crocodile,animal,악어");
    fruitList << QString::fromUtf8("pandas,animal,팬더");
    fruitList << QString::fromUtf8("elephant,animal,코끼리");
    fruitList << QString::fromUtf8("bear,animal,곰");
    fruitList << QString::fromUtf8("giraffe,animal,기린");
    fruitList << QString::fromUtf8("fox,animal,여우");
    fruitList << QString::fromUtf8("wolf,animal,늑대");
    fruitList << QString::fromUtf8("cheetah,animal,치타");
    fruitList << QString::fromUtf8("tiger,animal,호랑이");
    fruitList << QString::fromUtf8("mouse,animal,쥐");
    fruitList << QString::fromUtf8("rhino,animal,코뿔소");
    fruitList << QString::fromUtf8("zebra,animal,얼룩말");
    fruitList << QString::fromUtf8("monkey,animal,원숭이");
    fruitList << QString::fromUtf8("squirrel,animal,다람쥐");
    fruitList << QString::fromUtf8("skunk,animal,스컹크");
    fruitList << QString::fromUtf8("raccoon,animal,너구리");

    auto jsonArray = QJsonArray();
    foreach (QString item, fruitList){
        auto itemSplit = item.split(",", QString::SkipEmptyParts);
        //qDebug() << itemSplit;
        auto jsonObj = QJsonObject();
        jsonObj["name"] = itemSplit.at(0).trimmed();
        jsonObj["english"] = itemSplit.at(0).trimmed();
        jsonObj["front_img_name"] = itemSplit.at(0).trimmed();
        jsonObj["type"] = itemSplit.at(1).trimmed();
        jsonObj["korean"] = itemSplit.at(2).trimmed();

//        qDebug() << jsonObj.value("korean").toString();

        auto jsonValue = QJsonValue(jsonObj);
        jsonArray.append(jsonValue);
    }

    auto jsonDoc = QJsonDocument(jsonArray);

    // make jsarray
    m_cardList = QString::fromUtf8(jsonDoc.toJson(QJsonDocument::Compact));
    emit cardListChanged();

    foreach (QString engine, QTextToSpeech::availableEngines()){
        qDebug() << "engine name" << engine;
        engineSelected(engine);
        break;
    }
}

void Speech::speak(QString sentence)
{
    qDebug() << Q_FUNC_INFO << sentence;
    m_speech->say(sentence);
}
void Speech::stop()
{
    m_speech->stop();
}

void Speech::setRate(int rate)
{
    m_rate = rate;
    emit voiceRateChanged();
    m_speech->setRate(m_rate / 10.0);
}

void Speech::setPitch(int pitch)
{
    m_pitch = pitch;
    emit voicePitchChanged();
    m_speech->setPitch(m_pitch / 10.0);
}

void Speech::setVolume(int volume)
{
    m_speech->setVolume(volume / 10.0);
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

    auto voiceLanguageList = QStringList();
    auto currentLocale = m_speech->locale();

    // make back data
    foreach (const QLocale &locale, m_speech->availableLocales() ) {

        if( QLocale::languageToString(locale.language() ).contains("Korean") == true ){
            currentLocale = locale;
        }
        auto languageType =
            QString::fromUtf8("%1 %2,%3")
                 .arg(QLocale::languageToString(locale.language()))
                 .arg(QLocale::countryToString(locale.country()))
                 .arg(currentLocale == locale ? "true" : "false");

        if(
            languageType.contains("English") == true ||
            languageType.contains("Korean") == true
        //    languageType.contains("Japanese") == true ||
        //    languageType.contains("Chinese") == true
                ){
            m_locales.append(locale);
            voiceLanguageList.append( languageType );
        }

    }


    // make jsobject
    auto jsonArray = QJsonArray();
    foreach (QString item, voiceLanguageList){
        auto itemSplit = item.split(",", QString::SkipEmptyParts);
        //qDebug() << itemSplit;
        auto jsonObj = QJsonObject();
        jsonObj["language"] = itemSplit.at(0).trimmed();
        jsonObj["current"] = itemSplit.at(1).trimmed() == "true" ?  true : false;

//        qDebug() << jsonObj.value("korean").toString();

        auto jsonValue = QJsonValue(jsonObj);
        jsonArray.append(jsonValue);
    }

    auto jsonDoc = QJsonDocument(jsonArray);

    // make jsarray
    m_voiceLanguageList = QString::fromUtf8(jsonDoc.toJson(QJsonDocument::Compact));
//    qDebug() << Q_FUNC_INFO << m_voiceLanguageList;
    emit voiceLanguageListChanged();

    connect(m_speech, &QTextToSpeech::stateChanged, this, &Speech::stateChanged);
    connect(m_speech, &QTextToSpeech::localeChanged, this, &Speech::localeChanged);

    localeChanged(currentLocale);
    setPitch(m_pitch );
    setRate(m_rate);
}

void Speech::languageSelected(int index)
{
    auto locale = QLocale(m_locales.at(index));

    //selected value change
    auto jsonDoc = QJsonDocument::fromJson( m_voiceLanguageList.toLatin1() );
    if( jsonDoc.isArray() ) {

        auto jsonArray = jsonDoc.array(); // no reference value
        for(int i = 0; i < jsonArray.size(); i ++ ){

            auto jsonObj = jsonArray[i].toObject(); // no refernece value
//            qDebug() << Q_FUNC_INFO << index << jsonObj["language"].toString();
            if( i == index ){
                jsonObj["current"] = true;
            }
            else{
                jsonObj["current"] = false;
            }
            jsonArray[i] = jsonObj;
        }
        jsonDoc = QJsonDocument(jsonArray);
    }
    // make jsarray
    m_voiceLanguageList = QString::fromUtf8(jsonDoc.toJson(QJsonDocument::Compact));
    qDebug() << Q_FUNC_INFO << m_voiceLanguageList;
    emit voiceLanguageListChanged();

    m_speech->setLocale(locale);
    qDebug() << Q_FUNC_INFO <<  locale.name() << index;
}

void Speech::voiceSelected(int index)
{
    auto voice = m_voices.at(index);
    m_speech->setVoice(voice);
    qDebug() << Q_FUNC_INFO <<  voice.name() << index;
    makeVoiceTypeList();
}


void Speech::makeVoiceTypeList()
{
    auto voiceTypeList = QStringList();
    auto currentVoice = m_speech->voice();
    // make back data
    foreach (const QVoice &voice, m_voices) {
        voiceTypeList.append(
            QString::fromUtf8("%1,%2,%3,%4")
                  .arg(voice.name())
                  .arg(QVoice::genderName(voice.gender()))
                  .arg(QVoice::ageName(voice.age()))
                  .arg(currentVoice == voice ? "true" : "false")
            );
    }


    // make jsobject
    auto jsonArray = QJsonArray();
    foreach (QString item, voiceTypeList){
        auto itemSplit = item.split(",", QString::SkipEmptyParts);
        //qDebug() << itemSplit;
        auto jsonObj = QJsonObject();
        jsonObj["name"] = itemSplit.at(0).trimmed();
        jsonObj["gender"] = itemSplit.at(1).trimmed();
        jsonObj["age"] = itemSplit.at(2).trimmed();
        jsonObj["current"] = itemSplit.at(3).trimmed() == "true" ? true : false;

//        qDebug() << jsonObj.value("korean").toString();

        auto jsonValue = QJsonValue(jsonObj);
        jsonArray.append(jsonValue);
    }

    auto jsonDoc = QJsonDocument(jsonArray);

    // make jsarray
    m_voiceTypeList = QString::fromUtf8(jsonDoc.toJson(QJsonDocument::Compact));
    emit voiceTypeListChanged();
    qDebug() << Q_FUNC_INFO << m_voiceTypeList;
}

void Speech::localeChanged(const QLocale &locale)
{
    m_voices = m_speech->availableVoices();
    makeVoiceTypeList();
}
