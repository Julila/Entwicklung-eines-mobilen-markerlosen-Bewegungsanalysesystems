#-------------------------------------------------
#
# Project created by QtCreator 2017-01-05T15:08:17
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = EMMA
TEMPLATE = app

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += main.cpp\
        mainwindow.cpp

HEADERS  += mainwindow.h

FORMS    += mainwindow.ui

INCLUDEPATH += ../../inc/wiiuse/src

unix:LIBS += -static -L../../inc/wiiuse/build/src -llibwiiuse.so

win32:LIBS += ../../inc/wiiuse/build/src/Debug/wiiuse_debug.lib

win32 {
    WIIDLL = $${PWD}/../../inc/wiiuse/build/src/Debug/wiiuse_debug.dll
    WIIDLL_TARGET = $$system_path($${DESTDIR}/wiiuse_debug.dll)
    dllcopy.commands = copy $$system_path($$WIIDLL) $$system_path($$DESTDIR)
    dllcopy.target = $$WIIDLL_TARGET
    QMAKE_EXTRA_TARGETS += dllcopy
    PRE_TARGETDEPS += $$WIIDLL_TARGET
}
