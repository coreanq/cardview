#include "untitled_plugin.h"
#include "speech.h"

#include <qqml.h>

void SpeechPlugin::registerTypes(const char *uri)
{
    // @uri com.mycompany.qmlcomponents
    qmlRegisterType<Speech>(uri, 1, 0, "Speech");
}

