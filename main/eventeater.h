#ifndef EVENTEATER_H
#define EVENTEATER_H

#include <QObject>

class EventEater: public QObject
{
    Q_OBJECT
public:
    EventEater();

protected:
    bool eventFilter(QObject *obj, QEvent *event);

};

#endif // EVENTEATER_H
