######################################################################
# Automatically generated by qmake (3.0) Sun Feb 12 10:04:57 2017
######################################################################

EMMA_DIR = ../EMMA

QT += core concurrent testlib

TEMPLATE = app
TARGET = test
INCLUDEPATH += . \
    ../../inc/wiiuse/src \
    ../../inc/inih/cpp \
    ../../inc/QCustomPlot/src \
    ../../inc/QtOpenCV \
    $${EMMA_DIR} \
    $${EMMA_DIR}/body

# Input
SOURCES += test_currentstate.cpp \
        ../../inc/inih/ini.c \
        ../../inc/inih/cpp/INIReader.cpp \
        ../../inc/QtOpenCV/cvmatandqimage.cpp \
        $${EMMA_DIR}/ApplicationData.cpp \
        $${EMMA_DIR}/CurrentState.cpp \
        $${EMMA_DIR}/BalanceBoard.cpp \
        $${EMMA_DIR}/BalanceBoardThread.cpp \
	$${EMMA_DIR}/StreamIO.cpp \
        $${EMMA_DIR}/body/CvCamera.cpp \
        $${EMMA_DIR}/body/cvCapture.cpp \
        # $${EMMA_DIR}/body/cvConverter.cpp # removed because QImage requires QGuiApplication

HEADERS  += ../../inc/inih/ini.h \
        ../../inc/inih/cpp/INIReader.h \
        ../../inc/QtOpenCV/cvmatandqimage.h \
        $${EMMA_DIR}/ApplicationData.h \
        $${EMMA_DIR}/CurrentState.h \
        $${EMMA_DIR}/BalanceBoard.h \
        $${EMMA_DIR}/BalanceBoardThread.h \
	$${EMMA_DIR}/StreamIO.h \
        $${EMMA_DIR}/body/CvCamera.h \
        $${EMMA_DIR}/body/cvCapture.h \
        # $${EMMA_DIR}/body/cvConverter.h \ # removed because QImage requires QGuiApplication
        $${EMMA_DIR}/body/util.h

debug { DESTDIR = $${OUT_PWD}/debug }
release { DESTDIR = $${OUT_PWD}/release }
debug_and_release { DESTDIR = $${OUT_PWD}/bin }

CONFIG += c++11

win32 {
    SOURCES += $${EMMA_DIR}/body/KinectCamera.cpp
    HEADERS += $${EMMA_DIR}/body/KinectCamera.h
}

unix:LIBS += -L$${PWD}/../../inc/wiiuse/build/src -lwiiuse

win32:LIBS += ../../inc/wiiuse/build/src/Debug/wiiuse_debug.lib

win32 {
    wiidll.path = $${DESTDIR}
    wiidll.files = ../../inc/wiiuse/build/src/Debug/wiiuse_debug.dll
    INSTALLS += wiidll
}

win32:INCLUDEPATH += "$$(KINECTSDK20_DIR)/inc"\
        $$(OPENCV_DIR)/build/include

# set environment variable ARC to x86 or x64 if
# it is different from the architecture of the Qt build kit
ARC = $$(ARC)
isEmpty(ARC) {
    ARC = $$QMAKE_HOST.arch
    contains(ARC, x86_64) {
        ARC = x64
    } else {
        ARC = x86
    }
}

OPENCV_VER = $$(OPENCV_VER)

equals(OPENCV_VER, 310) {
        OPENCV_LIBDIR = $$(OPENCV_DIR)/build/$${ARC}/vc14/lib
} else {
        OPENCV_LIBDIR = $$(OPENCV_DIR)/build/$${ARC}/vc12/lib
}

debug {
        LIB_SUFFIX = d
} else {
        LIB_SUFFIX = ""
}

equals(OPENCV_VER, 310) {
        win32:LIBS += "$$(KINECTSDK20_DIR)/Lib/$${ARC}/Kinect20.lib"\
                $${OPENCV_LIBDIR}/opencv_world$$(OPENCV_VER)$${LIB_SUFFIX}.lib
} else {
        win32:LIBS += "$$(KINECTSDK20_DIR)/Lib/$${ARC}/Kinect20.lib"\
                $${OPENCV_LIBDIR}/opencv_calib3d$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_contrib$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_core$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_features2d$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_flann$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_gpu$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_highgui$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_imgproc$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_legacy$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_ml$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_nonfree$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_objdetect$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_ocl$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_photo$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_stitching$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_superres$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_ts$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_video$$(OPENCV_VER)$${LIB_SUFFIX}.lib\
                $${OPENCV_LIBDIR}/opencv_videostab$$(OPENCV_VER)$${LIB_SUFFIX}.lib
}

unix {
    CONFIG += link_pkgconfig
    PKGCONFIG += opencv
}
