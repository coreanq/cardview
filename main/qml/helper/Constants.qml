pragma Singleton
import QtQuick 2.0
// need to another folder from Main.qml
QtObject {

    // assets path for debug or release mode

    property string assetsPath: ""

    // detect debug mode
    property bool isDebugMode: false
    // ip address in release mode should be 127.0.0.1
    readonly property string cppInterfaceServerIpAddr: "ws://127.0.0.1:12345"

    // v-play licenseKey
    // for cardview
//    readonly property string vplaylicenseKey: "6577159175B1ABEF378D1A677808B8B8E034A940CAADCF9EBAD57B5ECF602EE5337F62CD8732736716ECD594301EB6FC1277718B88D84D6DE3ABFB25F0C08DE9CC6B9A6D7B4B6A16BF3FCE1B1A86EB619E2F3DB0CDCB229A682DE73108DFBC2F4F16747470EB2594CE4116B8CAE65353A2933424C72190AF77000E1C0161B6315CCCE2B2D51C10E1DABBE7BE00AD2A005B4115A2BB374FA02FD072E504E1A731C5796F37FDEA34BB16C501FA240C545F0BA1D9E2C36B5074A724159671AB509CB8AAFD08BC6EE67E1D115A5EF3CE381C2D1A76726C32CDC90759E9C96ABC3A55AD21580853E14721E866E9EB885A431DB696FA4A07479883F4671EDADACF1A7785FC4BF294FF5965DE8C2E6D55DA411AC33CAE8AC004AD44858CEE0BCAF41324F33D7FA91F1C7B4C98AB3466D57DC3C492FD62F0A728F268BE782217C20FB059"
    // for live load
    readonly property string vplaylicenseKey: "4DFA9C1A3C18F4F55EF2396D81A1F89B418C0940228E559A9990F3929E92CF18DDA3DEEF6C69ECE6AFD2DFB3165F07621902050D62BD1C3974EAFBDBE57603ED7B69D9A4D9D724C1FDE1C5A49E7EAC6D3E5693A44EAFE40394F6DF02528248837E994AB526433F9B0F90BDF32B25B8CD04F9CADC06FCB1EF5F6530A73A7D6C10A30599B9486C2E7F8D1AA2260F61875DE3EC29FE0E4AAFC368D61BB55B38A2927AFAF15E1B9557B8321EC2D743DFB5D4E4F0579569F6CE3B277F6BF73F5F52732CD878990A905458DA0B1D744AF1C6DFECCD145AD1FE2F2E251CC4DBDE41E23489BCEB44020090022912D0F60FAE68113EA7214B9CD21025701E36FCA651D3A5877517CD7B262E4C2A753A25F2BA5A38A3D55522DC5F6F53D2134E1831750AF2B829314E6B8E68184B298B8A5A77CEB77245CFC0C28CD139E7003A45E4AFCCCA"
    // AdMob
    readonly property string admobBannerAdUnitId: "ca-app-pub-1343411537040925/6004482526"
    readonly property string admobInterstitialAdUnitId: ""
    readonly property var admobTestDeviceIds: [ "" ]

}
