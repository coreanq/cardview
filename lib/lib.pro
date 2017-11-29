TEMPLATE = lib
TARGET = speechmodel
QT += qml quick
QT += texttospeech
CONFIG += plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = user.qmlplugins

# Input
SOURCES += \
    untitled_plugin.cpp \
    speech.cpp \
    qml_interface_model/qmlsortfilterproxymodel.cpp \
    qml_interface_model/qmlstandarditemmodel.cpp

HEADERS += \
    untitled_plugin.h \
    speech.h \
    qml_interface_model/qmlsortfilterproxymodel.h \
    qml_interface_model/qmlstandarditemmodel.h

DISTFILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}
