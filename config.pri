# Config.pri file version 2.0. Auto-generated by IDE. Any changes made by user will be lost!
BASEDIR = $$quote($$_PRO_FILE_PWD_)

device {
    CONFIG(debug, debug|release) {
        profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        } else {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }

    }

    CONFIG(release, debug|release) {
        !profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

simulator {
    CONFIG(debug, debug|release) {
        !profile {
            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

config_pri_assets {
    OTHER_FILES += \
        $$quote($$BASEDIR/assets/DetailsPage.qml) \
        $$quote($$BASEDIR/assets/InformationPage.qml) \
        $$quote($$BASEDIR/assets/ItemPage.qml) \
        $$quote($$BASEDIR/assets/LearningPage.qml) \
        $$quote($$BASEDIR/assets/LoginSheet.qml) \
        $$quote($$BASEDIR/assets/MemoDetailPage.qml) \
        $$quote($$BASEDIR/assets/MemoPage.qml) \
        $$quote($$BASEDIR/assets/PersonalPage.qml) \
        $$quote($$BASEDIR/assets/WordDetailPage.qml) \
        $$quote($$BASEDIR/assets/data.xml) \
        $$quote($$BASEDIR/assets/images/binoculars-128.png) \
        $$quote($$BASEDIR/assets/images/camera-128.png) \
        $$quote($$BASEDIR/assets/images/card-128.png) \
        $$quote($$BASEDIR/assets/images/chart-128.png) \
        $$quote($$BASEDIR/assets/images/clipboard-128.png) \
        $$quote($$BASEDIR/assets/images/cloud-128.png) \
        $$quote($$BASEDIR/assets/images/compass-128.png) \
        $$quote($$BASEDIR/assets/images/direction-128.png) \
        $$quote($$BASEDIR/assets/images/film-128.png) \
        $$quote($$BASEDIR/assets/images/flask-128.png) \
        $$quote($$BASEDIR/assets/images/folder-128.png) \
        $$quote($$BASEDIR/assets/images/graph-128.png) \
        $$quote($$BASEDIR/assets/images/hands-128.png) \
        $$quote($$BASEDIR/assets/images/id-128.png) \
        $$quote($$BASEDIR/assets/images/laboratory-128.png) \
        $$quote($$BASEDIR/assets/images/light_bulb-128.png) \
        $$quote($$BASEDIR/assets/images/lighthouse-128.png) \
        $$quote($$BASEDIR/assets/images/link-128.png) \
        $$quote($$BASEDIR/assets/images/medal-128.png) \
        $$quote($$BASEDIR/assets/images/money_bag-128.png) \
        $$quote($$BASEDIR/assets/images/music-128.png) \
        $$quote($$BASEDIR/assets/images/notepad_pencil-128.png) \
        $$quote($$BASEDIR/assets/images/pen_tool-128.png) \
        $$quote($$BASEDIR/assets/images/plane_mail-128.png) \
        $$quote($$BASEDIR/assets/images/plug-128.png) \
        $$quote($$BASEDIR/assets/images/search-128.png) \
        $$quote($$BASEDIR/assets/images/speed-128.png) \
        $$quote($$BASEDIR/assets/images/trophy-128.png) \
        $$quote($$BASEDIR/assets/images/wristwatch-128.png) \
        $$quote($$BASEDIR/assets/main.qml)
}

config_pri_source_group1 {
    SOURCES += \
        $$quote($$BASEDIR/src/applicationui.cpp) \
        $$quote($$BASEDIR/src/main.cpp)

    HEADERS += $$quote($$BASEDIR/src/applicationui.hpp)
}

INCLUDEPATH += $$quote($$BASEDIR/src)

CONFIG += precompile_header

PRECOMPILED_HEADER = $$quote($$BASEDIR/precompiled.h)

lupdate_inclusion {
    SOURCES += \
        $$quote($$BASEDIR/../src/*.c) \
        $$quote($$BASEDIR/../src/*.c++) \
        $$quote($$BASEDIR/../src/*.cc) \
        $$quote($$BASEDIR/../src/*.cpp) \
        $$quote($$BASEDIR/../src/*.cxx) \
        $$quote($$BASEDIR/../assets/*.qml) \
        $$quote($$BASEDIR/../assets/*.js) \
        $$quote($$BASEDIR/../assets/*.qs) \
        $$quote($$BASEDIR/../assets/images/*.qml) \
        $$quote($$BASEDIR/../assets/images/*.js) \
        $$quote($$BASEDIR/../assets/images/*.qs)

    HEADERS += \
        $$quote($$BASEDIR/../src/*.h) \
        $$quote($$BASEDIR/../src/*.h++) \
        $$quote($$BASEDIR/../src/*.hh) \
        $$quote($$BASEDIR/../src/*.hpp) \
        $$quote($$BASEDIR/../src/*.hxx)
}

TRANSLATIONS = $$quote($${TARGET}.ts)
