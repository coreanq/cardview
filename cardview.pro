TEMPLATE = app

QT += qml quick texttospeech
CONFIG += c++11 
CONFIG += v-play

SOURCES += main.cpp \
    speech.cpp \
    qml_interface_model/qmlsortfilterproxymodel.cpp \
    qml_interface_model/qmlstandarditemmodel.cpp \
    qml_interface_model/qmlsortfilterproxymodel.cpp \
    qml_interface_model/qmlstandarditemmodel.cpp \
    main.cpp \
    speech.cpp

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder
RESOURCES += #    resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# Default rules for deployment.
android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}
ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
    VPLAY_PLUGINS += admob
}

HEADERS += \
    speech.h \
    qml_interface_model/qmlsortfilterproxymodel.h \
    qml_interface_model/qmlstandarditemmodel.h \
    qml_interface_model/qmlsortfilterproxymodel.h \
    qml_interface_model/qmlstandarditemmodel.h \
    speech.h

DISTFILES += \
    qml/main.qml \
    qml/config.json \
    ios/Project-Info.plist \
    android/AndroidManifest.xml \
    android/build.gradle \
    assets/apple.jpg \
    assets/background.jpg \
    assets/card_back.jpg \
    assets/grape.jpg \
    assets/orange.jpg \
    assets/pineapple.jpg \
    assets/tomato.jpg \
    assets/add.png \
    assets/card_back.png \
    assets/click.png \
    assets/computer.png \
    assets/switch.png \
    assets/wired.png

# set application icons for win and macx
win32 {
    //RC_FILE += win/app_icon.rc
}
macx {
    //ICON = macx/app_icon.icns
}
