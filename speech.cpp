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

Speech::Speech(QObject *parent)
    : QObject(parent),
    m_speech(0), 
	m_languageModel(new QmlStandardItemModel() )
{
    foreach (QString engine, QTextToSpeech::availableEngines()){
//    	qDebug() << engine;
		engineSelected(engine);
		break;
	}
    
    // qmlStandardItemdModel 의 경우 header 를 가지고 user role 을 생성함 
    QStringList headers;
    headers << "first" << "second";
    m_languageModel->setHorizontalHeaderLabels(headers);
    m_languageModel->applyRoles(); // model header to user role 
}
QmlStandardItemModel* Speech::languageModel()
{
	return m_languageModel;
}
void Speech::speak()
{
    m_speech->say("Hello world");
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
//    disconnect(ui.language, static_cast<void (QComboBox::*)(int)>(&QComboBox::currentIndexChanged), this, &Speech::languageSelected);
//    ui.language->clear();
//    // Populate the languages combobox before connecting its signal.
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
//    setRate(ui.rate->value());
//    setPitch(ui.pitch->value());
//    setVolume(ui.volume->value());
//    connect(ui.stopButton, &QPushButton::clicked, m_speech, &QTextToSpeech::stop);
//    connect(ui.pauseButton, &QPushButton::clicked, m_speech, &QTextToSpeech::pause);
//    connect(ui.resumeButton, &QPushButton::clicked, m_speech, &QTextToSpeech::resume);

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
