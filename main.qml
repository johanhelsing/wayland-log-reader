import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import "./lodash.js" as Lodash
import "./wayland-debug-tools.js" as WaylandDebugTools

ApplicationWindow {
    id: window
    visible: true
    title: "wayland-log-reader"
    width: 1024
    height: 1024
    background: Rectangle { color: "white" }
    property int highlightObject: 0
    property string log: waylandLog

    function handleObjectSelected(object) {
        highlightObject = object.uniqueId;
    }

    ScrollView {
        id: objectsView
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width / 2
        Column {
            spacing: 3
            width: objectsView.width
            Label { text: "All objects"; font.weight: Font.Bold; font.pixelSize: 16 }
            Repeater {
                model: objects
                ObjectLabel { object: objects.get(index); onClicked: handleObjectSelected(object) }
            }
            Item { height: 5; width: 1 }
            Label { text: "Globals"; font.weight: Font.Bold; font.pixelSize: 16 }
            Repeater {
                model: globals
                Label { text: number + ": " + interfaceName + " v" + version }
            }
        }
    }

    ScrollView {
        id: messagesView
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width / 2
        clip: true

        Column {
            width: messagesView.width
            CheckBox {
                id: showComments
                text: "Show comments"
                checked: true
            }

            Repeater  {
                model: parsedLines
                Item {
                    id: lineItem
                    property var line: parsedLines[index]
                    width: parent.width
                    implicitWidth: childrenRect.width
                    implicitHeight: childrenRect.height
                    Repeater {
                        model: type === "comment" && showComments.checked
                        Label {
                            height: 25
                            text: rawText; color: "gray"
                        }
                    }
                    Repeater {
                        model: type === "event"
                        Row {
//                            anchors.right: parent.right
                            height: 25
                            spacing: 5
                            ObjectLabel { object: parts.object; onClicked: handleObjectSelected(object) }
                            Label { text: parts.fn }
                            Label { text: "(" }
                            Repeater {
                                model: parts.args
                                ArgumentItem { arg: parts.args[index]; onObjectSelected: handleObjectSelected(object) }
                            }
                            Label { text: ")" }
                        }
                    }
                    Repeater {
                        model: type === "request"
                        Row {
                            height: 25
                            spacing: 5
                            Label { text: " → " }
                            ObjectLabel { object: parts.object; onClicked: window.highlightObject = object.uniqueId }
                            Label { text: parts.fn }
                            Label { text: "(" }
                            Repeater {
                                model: parts.args
                                ArgumentItem { arg: parts.args[index]; onObjectSelected: handleObjectSelected(object) }
                            }
                            Label { text: ")" }
                        }
                    }
                }
            }
        }
    }

    property var state: ({})
    ListModel { id: parsedLines }
    ListModel { id: objects }
    ListModel { id: globals }

    function hash(str) {
        var hash = 0;
        if (this.length === 0)
            return hash;
        for (var i = 0; i < str.length; ++i) {
            const chr = str.charCodeAt(i);
            hash = ((hash << 5) - hash) + chr;
            hash |= 0; // Convert to 32bit integer
        }
        return hash;
    }

    function colorHash(value) {
        const hue = 0.5 + hash(Qt.md5(value)) / Math.pow(2, 32);
        return Qt.hsla(hue, 1, 0.4, 1);
    }

    Component.onCompleted: {
        state = WaylandDebugTools.parseLog(log);

        // add the lines to a model Qt understands
        state.parsedLines.forEach(function(line) {
            parsedLines.append(line);
        });

        // and the objets
        Lodash._.forEach(state.objects, function(object) {
            objects.append(object);
        });

        // and the globals
        Lodash._.forEach(state.globals, function(global) {
            globals.append(global);
        });
    }
}
