import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import "./lodash.js" as Lodash

AbstractButton {
    id: button
    property var object
    property bool highlighted: window.highlightObject === object.uniqueId
    text: object.interfaceName + "@" + object.id
    contentItem: Label {
        text: button.text
        color: object.uniqueId ? colorHash(object.uniqueId) : "gray"
    }
    Rectangle {
        anchors.fill: parent
        color: "yellow"
        radius: 3
        visible: highlighted
        border.width: 2
        border.color: "red"
    }
}
