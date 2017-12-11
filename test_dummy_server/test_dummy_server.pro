TEMPLATE = app
QT += widgets texttospeech websockets webchannel


CONFIG += c++11 console 
CONFIG -= app_bundle

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    ../main/speech.cpp \
    ../main/qml_interface_model/qmlsortfilterproxymodel.cpp \
    ../main/qml_interface_model/qmlstandarditemmodel.cpp \
    ../main/webchannel_interface/websocketclientwrapper.cpp \
    ../main/webchannel_interface/websockettransport.cpp \
    mainwindow.cpp

HEADERS += \
    ../main/speech.h \
    ../main/qml_interface_model/qmlsortfilterproxymodel.h \
    ../main/qml_interface_model/qmlstandarditemmodel.h \
    ../main/webchannel_interface/websocketclientwrapper.h \
    ../main/webchannel_interface/websockettransport.h \
    mainwindow.h

FORMS += \
    mainwindow.ui
