TEMPLATE = app
CONFIG += v-play c++11
QT += widgets qml quick websockets webchannel texttospeech
    
SOURCES += main.cpp \ 
    speech.cpp \
    webchannel_interface/websocketclientwrapper.cpp \
    webchannel_interface/websockettransport.cpp

Debug {
    #DEPLOYMENTFOLDERS 해당 리소스를 showdow 빌드 디렉토리로 qrc 로 컴파일 하지 않고 복사함
    qmlFolder.source = qml
    DEPLOYMENTFOLDERS += qmlFolder 

    assetsFolder.source = assets
    DEPLOYMENTFOLDERS += assetsFolder
}
Release{
    RESOURCES += assets.qrc 
}


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

    qmlFiles.files = $$files(qml/*.*)
    qmlFiles.path = qml
    QMAKE_BUNDLE_DATA += qmlFiles

    assetsFiles.files = $$files(assets/*.*)
    assetsFiles.path = assets
    QMAKE_BUNDLE_DATA += assetsFiles
    RESOURCES += assets.qrc
}
win32 {
    #RC_FILE += win/app_icon.rc
}
macx {
    #ICON = macx/app_icon.icns
}


DISTFILES += \
    qml/config.json \
    ios/Project-Info.plist \
    android/AndroidManifest.xml \
    android/build.gradle \
    assets/*.jpg \
    qml/Main.qml \
    qml/Constant.qml \
    webchannel_interface/qwebchannel.js

HEADERS += \
    speech.h \
    webchannel_interface/websocketclientwrapper.h \
    webchannel_interface/websockettransport.h \

