# Config.pri file version 2.0. Auto-generated by IDE. Any changes made by user will be lost!
BASEDIR = $$quote($$_PRO_FILE_PWD_)

device {
    CONFIG(debug, debug|release) {
        profile {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            LIBS += -lQtSql \
                -lsqlite3 \
                -lbbdata

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        } else {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            LIBS += -lQtSql \
                -lsqlite3 \
                -lbbdata

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }

    }

    CONFIG(release, debug|release) {
        !profile {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            LIBS += -lQtSql \
                -lsqlite3 \
                -lbbdata

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

simulator {
    CONFIG(debug, debug|release) {
        !profile {
            INCLUDEPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            DEPENDPATH += $$quote(${QNX_TARGET}/usr/include/qt4/QtSql) \
                $$quote(${QNX_TARGET}/usr/include/bb/data)

            LIBS += -lQtSql \
                -lsqlite3 \
                -lbbdata

            CONFIG += \
                config_pri_assets \
                config_pri_source_group1
        }
    }
}

config_pri_assets {
    OTHER_FILES += \
        $$quote($$BASEDIR/assets/HomePage.qml) \
        $$quote($$BASEDIR/assets/LearningAdd.qml) \
        $$quote($$BASEDIR/assets/LearningDetail.qml) \
        $$quote($$BASEDIR/assets/LearningList.qml) \
        $$quote($$BASEDIR/assets/MemoAdd.qml) \
        $$quote($$BASEDIR/assets/MemoDetail.qml) \
        $$quote($$BASEDIR/assets/MemoList.qml) \
        $$quote($$BASEDIR/assets/images/Language_Setting.png) \
        $$quote($$BASEDIR/assets/images/Note_Book.png) \
        $$quote($$BASEDIR/assets/images/add.png) \
        $$quote($$BASEDIR/assets/images/book.png) \
        $$quote($$BASEDIR/assets/images/box.png) \
        $$quote($$BASEDIR/assets/images/error.png) \
        $$quote($$BASEDIR/assets/images/language.png) \
        $$quote($$BASEDIR/assets/images/marker.png) \
        $$quote($$BASEDIR/assets/images/refresh.png) \
        $$quote($$BASEDIR/assets/images/star.png) \
        $$quote($$BASEDIR/assets/main.qml) \
        $$quote($$BASEDIR/assets/nicome.s3db)
}

config_pri_source_group1 {
    SOURCES += \
        $$quote($$BASEDIR/src/applicationui.cpp) \
        $$quote($$BASEDIR/src/main.cpp)

    HEADERS += $$quote($$BASEDIR/src/applicationui.hpp)
}

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
