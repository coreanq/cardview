import QtQuick 2.0

Item {

    id: _root
    signal leftrightSwipe(real moveRatio)
    signal rightleftSwipe(real moveRatio)
    signal topbottomSwipe(real moveRatio)
    signal bottomtopSwipe(real moveRatio)
    signal clicked()
    signal released()

    Component.onCompleted: {
        _mouseArea.clicked.connect(_root.clicked)
        _mouseArea.released.connect(_root.released)
    }

    MouseArea {
         id: _mouseArea
         property int startXpoint: 0
         property int startYpoint: 0

         anchors.fill: parent
         onPressed: {
             startXpoint = mouse.x
             startYpoint = mouse.y
         }
         onPositionChanged: {
             // detect small move lager than 10
    //             if( abs(startXpoint - mouse.x) < 10 )
    //                 return;
             var moveXpoint = Math.abs(startXpoint - mouse.x)
             var moveYpoint = Math.abs(startYpoint - mouse.y)

             if( startXpoint <= mouse.x ){
                 leftrightSwipe( moveXpoint / parent.width);
    //                 console.log("left-right swipe")
             }
             else {
                 rightleftSwipe( moveXpoint / parent.width)
    //                 console.log("right-left swipe")
             }

             if( startYpoint <= mouse.y ){
                 topbottomSwipe( moveYpoint / parent.height)
    //                 console.log("top-bottom swipe")
             }
             else {
                 bottomtopSwipe( moveYpoint / parent.height)
    //                 console.log("bottom-top swipe")
             }
         }
     }
}
