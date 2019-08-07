TEMPLATE = app
CONFIG += felgo
QT += widgets qml quick websockets webchannel texttospeech

SOURCES += main.cpp \
    speech.cpp \
    webchannel_interface/websocketclientwrapper.cpp \
    webchannel_interface/websockettransport.cpp \
    qml_interface_model/qmlsortfilterproxymodel.cpp \
    qml_interface_model/qmlstandarditemmodel.cpp

# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
#PRODUCT_IDENTIFIER = com.home.cardview
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 7

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
#PRODUCT_LICENSE_KEY = "9ACDE3BAEEE6541A95EA3F67F154FAEB23CFFA10C41975B2212A8BE906182167F7BD326F8CB03CD22E4430D6F15A7D2C1E681B32F5B11CFD539CC4B82D3A4C1F2B984F6BA487D3F7A8B491794F52DC38B56358A8B20B65C1C5C2983863270987A58A733D26A211729B3B31A1514FB523FA4660092359851D87D83A358160129937852AB17A55FB7DDC36C3011F5C6A7C843210942D1A26E2CDB632CD0DC81C4E10E08908FFC95B662963CC9AD738E437187206AF72DD345359C1C24F3E63924CFED190F0570E5183041A1ACAA5E1968EBB5DC3F48DC39468653141F93CD0E0D4BFCC61B926D801B1476785314B074FE180233D1C2601923B8BEE5D9D175276E0B220D7DE14986AEA98049896C18E1B77257E70AAC7A20789820B1107E5C9841333DE124CCBA2D1F8F7D963A70E969084C0DFA3E10EA55274D229DB22504BD437"

#DEFINES += FELGO_LIVE_SERVER

contains(DEFINES, FELGO_LIVE_SERVER){
    message("~~~~felgo_liver_server")
    PRODUCT_IDENTIFIER = "com.home.liveload"
}
else {
    message("~~~~normal application")
    PRODUCT_IDENTIFIER = "com.home.cardview"
}

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the V-Play Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# Default rules for deployment.
assetsFolder.files = $$files(assets, true)  # source folder or file
assetsFolder.path = # destination folder name in bundle
QMAKE_BUNDLE_DATA += assetsFolder

FELGO_PLUGINS += admob

CONFIG(debug, debug|release) {
    # QMAKE_BUNDLE_DATA Specifies the data that will be installed with a library bundle
    qmlFolder.files = $$files(qml, true) # $$file 에 폴더명을 지정하는 경우 폴더 복사함, 2번째 인자는 recursive
    qmlFolder.path =  # 복사한 폴더이름 폴더 복사의 경우 폴더째 통째로 되므로 생략가능
    QMAKE_BUNDLE_DATA += qmlFolder # comment for publishing

}
CONFIG(release, debug|release) {
    RESOURCES += assets.qrc
}
android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}
ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
    QMAKE_ASSET_CATALOGS = $$PWD/ios/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"

    plugins.files = $$PWD/ios/PlugIns/widget.appex
    plugins.path = PlugIns  # 파일만 지정하였으므로 폴더를 만들어서 복사해줌:ㅈ
    QMAKE_BUNDLE_DATA += plugins
}
win32 {
    #RC_FILE += win/app_icon.rc
}
macx {
    #ICON = macx/app_icon.icns
}


HEADERS += \
    webchannel_interface/websocketclientwrapper.h \
    webchannel_interface/websockettransport.h \
    qml_interface_model/qmlsortfilterproxymodel.h \
    qml_interface_model/qmlstandarditemmodel.h \
    speech.h

OTHER_FILES += \
    assets.qrc

