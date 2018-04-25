.pragma library
.import "./lodash.js" as Lodash

const re = {
//        logLine: /^\[\d{7}\.\d{3}\] (.*)$/,
    logLine: /^\[ {0,7}\d{0,7}\.\d{3}\] (( -> )?(\w+@\d+)\.(\w+)\((.*)\))$/,
    sentMessage: /^ -> (.*)$/,
    message: /^(\w+@\d+)\.(\w+)\((.*)\)$/,
    arguments: /^$/,
    newId: /^new id ((\w+|\[\unknown\])@\d+)$/,
    object: /^(\w+|\[unknown\])@(\d+)$/
};

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

function splitArgs(text) {
    var startPos = 0;
    var inString = false;
    const args = [];
    for (var i = 0;; ++i) {
        const ch = text[i];
        if (!ch) {
            if (i > startPos)
                args.push(text.slice(startPos, i));
            break;
        }

        if (!inString && ch === ",") {
            args.push(text.slice(startPos, i));
            startPos = i + 2;
            ++i; //skip space inbetween
        }

        if (i === startPos)
            inString = ch === "\"";
        else if (inString && ch === "\"" && text[i-1] !== "\\")
            inString = false;
    }
    return args;
}

function parseArgs(args) {
    return splitArgs(args).map(function(arg) {
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

var nextId = 1;
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

//TODO: currently state will be modified... could perhaps copy it first to have a cleaner API
function processLogLine(state, line) {
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
    }

    return state;
}

function parseLog(log) {
    const lines = log.split('\n');

    const state = { parsedLines: [], objects: {}, liveObjectsById: {}, globals: {} };
    const displayObject = { interfaceName: "wl_display", id: 1, uniqueId: getUniqueId() } ;
    state.objects[displayObject.uniqueId] = displayObject;
    state.liveObjectsById[displayObject.id] = displayObject;

    state = Lodash._.reduce(lines, processLogLine, state);

    return state;
}
