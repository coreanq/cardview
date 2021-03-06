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



#ifndef SPEECH_H
#define SPEECH_H

#include <QTextToSpeech>
#include <QVector>
#include <QString>
#include <QStringList>
#include <QNetworkAccessManager>
#include "qml_interface_model/qmlstandarditemmodel.h"

class Speech : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QmlStandardItemModel* languageModel READ languageModel WRITE setLanguageModel NOTIFY languageModelChanged) 
public:
    Speech(QObject *parent = 0);
   	// copy, assign 생성자 delete 속성  제거  
    Speech &operator =( Speech &obj ) {return obj;}
    Speech(const Speech & obj) {}

    QmlStandardItemModel* languageModel();
    void setLanguageModel(QmlStandardItemModel* model) { m_languageModel = model;}
    

signals:
	void languageModelChanged();
	void dataRecved(QString msg);

public slots:
    
    void requestGet();
    void requestReceived(QNetworkReply *reply);
    void speak(QString sentence);
    void stop();

    void setRate(int);
    void setPitch(int);
    void setVolume(int volume);

    void stateChanged(QTextToSpeech::State state);
    void engineSelected(QString engineName);
    void languageSelected(int language);
    void voiceSelected(int index);

    void localeChanged(const QLocale &locale);

private:
	QmlStandardItemModel* m_languageModel;
    QTextToSpeech *m_speech;
    QVector<QVoice> m_voices;
    QNetworkAccessManager *m_manager = new QNetworkAccessManager(this);
};
 Q_DECLARE_METATYPE(Speech)
#endif
