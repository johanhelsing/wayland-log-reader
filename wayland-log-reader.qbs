import qbs

Project {
    minimumQbsVersion: "1.7.1"

    CppApplication {
        Depends { name: "Qt.core" }
        Depends { name: "Qt.quick" }

        // Additional import path used to resolve QML modules in Qt Creator's code model
        property pathList qmlImportPaths: []

        cpp.cxxLanguageVersion: "c++11"

        cpp.defines: [
            "QT_DEPRECATED_WARNINGS",
            //"QT_DISABLE_DEPRECATED_BEFORE=0x060000" // disables all the APIs deprecated before Qt 6.0.0
        ]

        files: [
            "main.cpp",
            "qml.qrc",
        ]

        Group {
            fileTagsFilter: "application"
            qbs.install: true
            qbs.installDir: "bin"
        }

        qbs.installPrefix: "usr/local"
    }
}
