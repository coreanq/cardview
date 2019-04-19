pragma Singleton
import QtQuick 2.0
// need to another folder from Main.qml
QtObject {


    readonly property string cppInterfaceServerIpAddr: "ws://localhost:17061"
//    readonly property string cppInterfaceServerIpAddr: "ws://192.168.137.1:17061"

    // v-play licenseKey
    // for cardview
    readonly property string vplaylicenseKey: "614D8B0B5A50CDF7F8DC36195401256AEDAC8630F17AB0215DEA10F499633E1F69DF8BE4AEB97AA131BBBE22361FF3133B63A9EC5EF7F1AD2D59C202F6783BA859A6A4C66B818B56ADC0EB0CE9C5C7CC227CD339441DBB13C9B504F856620C7091830FDE17724646AB4C3137CD11B41B58D763A6834C7992AC61C2A99DA4512BE6E3E5E1A9E7465C6BF4680C54D2689D5F630A2259EA5502057B02078363E65E6993CB7AE3C0481E0C21F8811DF9F69EEFF8F78F651A157B616A57348908CB9FDB61CCEC080D9306520DB8931E3F2E0D33143D8E76F7E5E68E086BB20A3C5BBB2C5EAF3D52932B12BCF61F7D6576DF429E7C34CE7F9DD5E4039F8393A7F0BD045658AA7FB4D4932A39EE888ED9FE2E778970C74CB14F41BDB92E7767607A4A210AF0AAC326CA099D43C4AEE5857461BE090BCCF8AE1EC49442B8D2236F3F3DF5"
    // for live load
//    readonly property string vplaylicenseKey: "D64CF1C108E7D190959AE34417D945EA10838C65E32D6B4C0013C490527865B2F1EDDE3A248B1E3EFF33D73A437CA07AF3C189335A7FD04040BAA2BA2B8D567312365A2E07CFF7057AFC6C732035CB07580B1E8A3F233040B3F873D568C039D3D07BC963AADB5F2E4B9BEE056D48F95E63419B663E99F0DD6A11810BE4F86EE773F451DE49D4AE09ED8A3DB379CBEF7204CF7C9770AE531D6B82F3956155AEF8A7F91531FC19955B636439C62B717341F3B56FAC6EF3021556BB95EE20C6AC16A4589C45DBCE9D84127B56A9D6ABC4EB952F30693449B34068F6056A7D62E46F00AC7BC63232052440C5F0C07415C6446D7CA4947CCBDDB57D7B9B0B76C522B1439B925DCE2237E331530BC171209E71762792A913719468A32EE0FFD9F5CEE8D0CA3A77BD98050BF660654D7C8548FB92ADBCE80C19966DBB5CFC9A3C252164"
    // AdMob
    readonly property string admobBannerAdUnitId: "ca-app-pub-1343411537040925/1982300395"
    readonly property string admobInterstitialAdUnitId: ""
    readonly property var admobTestDeviceIds: [ "" ]

}
