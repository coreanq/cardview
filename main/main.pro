TEMPLATE = app
CONFIG += c++14
CONFIG += v-play
CONFIG += v-play-live
QT += widgets qml quick websockets webchannel texttospeech

SOURCES += main.cpp \
    speech.cpp \
    webchannel_interface/websocketclientwrapper.cpp \
    webchannel_interface/websockettransport.cpp \
    qml_interface_model/qmlsortfilterproxymodel.cpp \
    qml_interface_model/qmlstandarditemmodel.cpp \
    webchannel_interface/websocketclientwrapper.cpp \
    webchannel_interface/websockettransport.cpp \


DEFINES += NO_VPLAY_LIVE_SERVER

PRODUCT_IDENTIFIER = "com.home.cardview"

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

    CONFIG(debug, debug|release) {
        # QMAKE_BUNDLE_DATA Specifies the data that will be installed with a library bundle
        # 설치 폴더로 복사
        qmlFolder.source = qml
        DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

        assetsFolder.source = assets
        DEPLOYMENTFOLDERS += assetsFolder

    }
    CONFIG(release, debug|release) {
        RESOURCES +=
    }
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
    qml/qmldir

HEADERS += \
    speech.h \
    webchannel_interface/websocketclientwrapper.h \
    webchannel_interface/websockettransport.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMAdNetworkAdapterProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMAdNetworkConnectorProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMediationAdRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMEnums.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMRewardBasedVideoAdNetworkAdapterProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMRewardBasedVideoAdNetworkConnectorProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPBannerView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPCustomRenderedAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPCustomRenderedBannerViewDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPCustomRenderedInterstitialDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPInterstitial.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdChoicesView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdLoader.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdLoaderAdTypes.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdLoaderDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdNetworkExtras.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdReward.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdSize.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdSizeDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAppEventDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADBannerView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADBannerViewDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCorrelator.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCorrelatorAdLoaderOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventBanner.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventBannerDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventExtras.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventInterstitial.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventInterstitialDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventNativeAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventNativeAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventParameters.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADDebugOptionsViewController.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADDynamicHeightSearchRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADExtras.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInAppPurchase.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInAppPurchaseDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInterstitial.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInterstitialDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAdNotificationSource.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAppInstallAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeContentAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediaView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMobileAds.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdImage+Mediation.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdImage.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdImageAdLoaderOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdViewAdOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAppInstallAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeContentAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeCustomTemplateAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeExpressAdView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeExpressAdViewDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRequestError.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRewardBasedVideoAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRewardBasedVideoAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADSearchBannerView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADSearchRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADVideoController.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADVideoControllerDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADVideoOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GoogleMobileAds.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GoogleMobileAdsDefines.h \
    qml_interface_model/qmlsortfilterproxymodel.h \
    qml_interface_model/qmlstandarditemmodel.h \
    webchannel_interface/websocketclientwrapper.h \
    webchannel_interface/websockettransport.h \
    speech.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMAdNetworkAdapterProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMAdNetworkConnectorProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMediationAdRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMEnums.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMRewardBasedVideoAdNetworkAdapterProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/Mediation/GADMRewardBasedVideoAdNetworkConnectorProtocol.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPBannerView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPCustomRenderedAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPCustomRenderedBannerViewDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPCustomRenderedInterstitialDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPInterstitial.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/DFPRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdChoicesView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdLoader.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdLoaderAdTypes.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdLoaderDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdNetworkExtras.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdReward.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdSize.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAdSizeDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADAppEventDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADBannerView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADBannerViewDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCorrelator.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCorrelatorAdLoaderOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventBanner.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventBannerDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventExtras.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventInterstitial.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventInterstitialDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventNativeAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventNativeAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventParameters.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADCustomEventRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADDebugOptionsViewController.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADDynamicHeightSearchRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADExtras.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInAppPurchase.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInAppPurchaseDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInterstitial.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADInterstitialDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAdNotificationSource.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeAppInstallAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediatedNativeContentAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMediaView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADMobileAds.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdImage+Mediation.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdImage.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdImageAdLoaderOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAdViewAdOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeAppInstallAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeContentAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeCustomTemplateAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeExpressAdView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADNativeExpressAdViewDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRequestError.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRewardBasedVideoAd.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADRewardBasedVideoAdDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADSearchBannerView.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADSearchRequest.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADVideoController.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADVideoControllerDelegate.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GADVideoOptions.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GoogleMobileAds.h \
    ios/GoogleMobileAds.framework/Versions/A/Headers/GoogleMobileAdsDefines.h

RESOURCES += \
    assets.qrc

