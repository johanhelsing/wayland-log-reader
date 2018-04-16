import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import "./lodash.js" as Lodash

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
                            Label { text: " -> " }
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
    property var re: ({
        logLine: /^\[\d{7}\.\d{3}\] (.*)$/,
        sentMessage: /^ -> (.*)$/,
        message: /^(\w+@\d+)\.(\w+)\((.*)\)$/,
        arguments: /^$/,
        newId: /^new id ((\w+|\[\unknown\])@\d+)$/,
        object: /^(\w+|\[unknown\])@(\d+)$/
    })

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

    function parseNewId(arg) {
        const parts = arg.match(re.newId);
        if (!parts)
            return;
        const object = parseObject(parts[1])
        return { type: "new", object: object, rawText: arg };
    }

    function parseInteger(arg) {
        const value = parseInt(arg);
        if (isNaN(value))
            return;
        return { type: "integer", value: value, rawText: arg };
    }

    function parseString(arg) {
        try {
            const value = JSON.parse(arg);
            if (typeof value === "string")
                return { type: "string", value: value, rawText: arg };
        } catch (e) {}
        return;
    }

    function parseArgs(args) {
        // let's do it the shitty way and just split on comma
        return args.split(', ').map(function(arg) {
            return parseNewId(arg) ||
                    parseObject(arg) ||
                    parseInteger(arg) ||
                    parseString(arg) ||
                    { type: "unknown", rawText: arg };
        });
    }

    function parseObject(object) {
        const parts = object.match(re.object);
        if (!parts)
            return;
        return { type: "object", interfaceName: parts[1], id: parseInt(parts[2]), rawText: object };
    }

    function parseMessage(message) {
        const matches = message.match(re.message);
        const object = parseObject(matches[1]);
        const args = parseArgs(matches[3]);
        return {object: object, fn: matches[2], args: args, rawText: message};
    }

    function parseLine(line) {
        const lineParts = line.match(re.logLine);
        if (!lineParts)
            return {type: "comment", parts: {comment: line}, rawText: line};

        const message = lineParts[1];
        const sentMessage = message.match(re.sentMessage);
        const parsedMessage = parseMessage(sentMessage ? sentMessage[1] : message);

        const type = sentMessage ? "request" : "event"; // TODO: support server logs
        return { type: type, parts: parsedMessage, rawText: line };
    }

    property int nextId: 1
    function getUniqueId() {
        return nextId++;
    }

    function updateUniqueId(object, liveObjects) {
        const objectInfo = liveObjects[object.id];
        if (!objectInfo) {
//            console.warn("couldn't find live id", object.id);
            return;
        }
        object.uniqueId = objectInfo.uniqueId;
    }

    function updateLiveObjects(line, state) {
        if (line.type !== "event" && line.type !== "request")
            return;

        line.parts.args.forEach(function(arg) {
            if (arg.type === "new") {
                const id = arg.object.id;
                if (state.liveObjectsById[id])
                    console.warn(id, "is already in db, something is wrong, continuing anyway");
                const uniqueId = getUniqueId();
                const object = { interfaceName: arg.object.interfaceName, id: arg.object.id, uniqueId: uniqueId };
                state.objects[uniqueId] = object;
                state.liveObjectsById[id] = object;
            }
        });
    }

    function parseLog(log) {
        const lines = log.split('\n');

        const initialState = { parsedLines: [], objects: {}, liveObjectsById: {}, globals: {} };
        const displayObject = { interfaceName: "wl_display", id: 1, uniqueId: getUniqueId() } ;
        initialState.objects[displayObject.uniqueId] = displayObject;
        initialState.liveObjectsById[displayObject.id] = displayObject;

        state = Lodash._.reduce(lines, function(state, line, lineNumber) {
            const parsedLine = parseLine(line);
            state.parsedLines.push(parsedLine);

            //easier access
            const type = parsedLine.type;
            const parts = parsedLine.parts;
            const object = parts && parts.object;
            const fn = parts && parts.fn;
            const args = parts && parts.args;

            if (type === "event" && object.interfaceName === "wl_registry" && fn === "global")
                state.globals[args[0].value] = { number: args[0].value, interfaceName: args[1].value, version: args[2].value};

            if (type === "request" && object.interfaceName === "wl_registry" && fn === "bind") {
                const global = state.globals[args[0].value];
                parsedLine.global = global;
                args[3].object.interfaceName = global.interfaceName;
            }

            if (type === "event" || type === "request") {
                updateLiveObjects(parsedLine, state);

                updateUniqueId(object, state.liveObjectsById);
                args.forEach(function(arg) {
                    if (arg.type === "object")
                        updateUniqueId(arg, state.liveObjectsById);
                    else if (arg.type === "new")
                        updateUniqueId(arg.object, state.liveObjectsById);
                });

                //TODO: set unique ids for arguments also
            }

            return state;
        }, initialState);

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
    Component.onCompleted: parseLog(log)
}
