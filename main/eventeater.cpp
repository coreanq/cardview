#include "eventeater.h"
#include <QEvent>


EventEater::EventEater()
{

}

bool EventEater::eventFilter(QObject *obj, QEvent *event)
{
  if (event->type() == QEvent::KeyPress) {
//          QKeyEvent *keyEvent = static_cast<QKeyEvent *>(event);
      qDebug("Ate key press ");
      return true;
  }
  else if (event->type() == QEvent::WindowActivate) {
      qDebug("Activate" );
      return true;
  }
  else if ( event->type() == QEvent::WindowDeactivate) {
      qDebug("Deactivate" );
  }
  else {
      // standard event processing
      qDebug("." );
      return QObject::eventFilter(obj, event);
  }
}
