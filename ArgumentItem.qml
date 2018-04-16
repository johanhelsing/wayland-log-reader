import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import "./lodash.js" as Lodash

Rectangle {
    id: argumentItem
    property var arg
    signal objectSelected(var object)
    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height
    color: "#ddd"
    radius: 3
    Repeater {
        model: argumentItem.arg.type === "object"
        ObjectLabel { object: argumentItem.arg; onClicked: argumentItem.objectSelected(object) }
    }
    Repeater {
        model: argumentItem.arg.type === "new"
        Row {
            spacing: 5
            Label { text: "new"; font.weight: Font.Bold }
            ObjectLabel { object: argumentItem.arg.object; onClicked: argumentItem.objectSelected(object) }
        }
    }
    Repeater {
        model: argumentItem.arg.type !== "object" && argumentItem.arg.type !== "new"
        Label { text: argumentItem.arg.rawText }
    }
}
