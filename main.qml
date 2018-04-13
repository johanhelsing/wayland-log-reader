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
    property string log: '~/d/q/b/1/q/t/a/g/k/qopenglwindow env WAYLAND_DEBUG=1 env EGL_LOG_LEVEL=debug WAYLAND_DISPLAY=wayland-3 LIBGL_ALWAYS_SOFTWARE=1 ./tst_qopenglwindow readPixels
[2996031.536]  -> wl_display@1.get_registry(new id wl_registry@2)
[2996031.612]  -> wl_display@1.sync(new id wl_callback@3)
[2996031.742] wl_display@1.delete_id(3)
[2996031.788] wl_registry@2.global(1, "wl_compositor", 4)
[2996031.835]  -> wl_registry@2.bind(1, "wl_compositor", 3, new id [unknown]@4)
[2996031.858] wl_registry@2.global(2, "wl_subcompositor", 1)
[2996031.870]  -> wl_registry@2.bind(2, "wl_subcompositor", 1, new id [unknown]@5)
[2996031.895] wl_registry@2.global(3, "wp_viewporter", 1)
[2996031.910] wl_registry@2.global(4, "wp_presentation", 1)
[2996031.928] wl_registry@2.global(5, "zwp_relative_pointer_manager_v1", 1)
[2996031.944] wl_registry@2.global(6, "zwp_pointer_constraints_v1", 1)
[2996031.960] wl_registry@2.global(7, "wl_data_device_manager", 3)
[2996031.976]  -> wl_registry@2.bind(7, "wl_data_device_manager", 1, new id [unknown]@6)
[2996031.999] wl_registry@2.global(8, "wl_shm", 1)
[2996032.016]  -> wl_registry@2.bind(8, "wl_shm", 1, new id [unknown]@7)
[2996032.037] wl_registry@2.global(9, "wl_output", 3)
[2996032.055]  -> wl_registry@2.bind(9, "wl_output", 2, new id [unknown]@8)
[2996032.083]  -> wl_display@1.sync(new id wl_callback@9)
[2996032.091] wl_registry@2.global(10, "zwp_input_panel_v1", 1)
[2996032.108] wl_registry@2.global(11, "zwp_text_input_manager_v1", 1)
[2996032.127] wl_registry@2.global(12, "zxdg_shell_v6", 1)
[2996032.144] wl_registry@2.global(13, "xdg_shell", 1)
[2996032.159] wl_registry@2.global(14, "wl_shell", 1)
[2996032.175] wl_registry@2.global(15, "weston_desktop_shell", 1)
[2996032.191] wl_registry@2.global(16, "weston_screenshooter", 1)
[2996032.207] wl_callback@3.done(43)
[2996032.279] wl_display@1.delete_id(9)
[2996032.289] wl_shm@7.format(0)
[2996032.310] wl_shm@7.format(1)
[2996032.318] wl_output@8.geometry(0, 0, 1024, 640, 0, "weston", "headless", 0)
[2996032.354] wl_output@8.scale(1)
[2996032.361] wl_output@8.mode(3, 1024, 640, 60000)
[2996032.377] wl_output@8.done()
[2996032.400] wl_callback@9.done(43)
[2996032.497]  -> wl_shm@7.create_pool(new id wl_shm_pool@9, fd 5, 9216)
[2996033.758]  -> wl_shm_pool@9.resize(27648)
[2996035.215]  -> wl_shm_pool@9.resize(64512)
[2996042.886]  -> wl_shm_pool@9.resize(138240)
[2996043.012]  -> wl_shm_pool@9.resize(285696)
[2996043.209]  -> wl_shm_pool@9.resize(580608)
[2996043.582]  -> wl_shm_pool@9.resize(1170432)
[2996048.777]  -> wl_shm_pool@9.resize(2350080)
[2996070.442]  -> wl_shm_pool@9.resize(4709376)
********* Start testing of tst_QOpenGLWindow *********
Config: Using QtTest library 5.11.0, Qt 5.11.0 (x86_64-little_endian-lp64 shared (dynamic) debug build; by Clang 6.0.0 (tags/RELEASE_600/final))
QDEBUG : tst_QOpenGLWindow::initTestCase() Using Wayland-EGL
[2996128.694]  -> wl_display@1.get_registry(new id wl_registry@3)
[2996128.726]  -> wl_display@1.sync(new id wl_callback@10)
[2996128.936] wl_display@1.delete_id(10)
[2996128.953] wl_registry@3.global(1, "wl_compositor", 4)
[2996128.969] wl_registry@3.global(2, "wl_subcompositor", 1)
[2996128.995] wl_registry@3.global(3, "wp_viewporter", 1)
[2996129.003] wl_registry@3.global(4, "wp_presentation", 1)
[2996129.020] wl_registry@3.global(5, "zwp_relative_pointer_manager_v1", 1)
[2996129.040] wl_registry@3.global(6, "zwp_pointer_constraints_v1", 1)
[2996129.052] wl_registry@3.global(7, "wl_data_device_manager", 3)
[2996129.064] wl_registry@3.global(8, "wl_shm", 1)
[2996129.074]  -> wl_registry@3.bind(8, "wl_shm", 1, new id [unknown]@11)
[2996129.089] wl_registry@3.global(9, "wl_output", 3)
[2996129.099] wl_registry@3.global(10, "zwp_input_panel_v1", 1)
[2996129.111] wl_registry@3.global(11, "zwp_text_input_manager_v1", 1)
[2996129.123] wl_registry@3.global(12, "zxdg_shell_v6", 1)
[2996129.133] wl_registry@3.global(13, "xdg_shell", 1)
[2996129.143] wl_registry@3.global(14, "wl_shell", 1)
[2996129.155] wl_registry@3.global(15, "weston_desktop_shell", 1)
[2996129.165] wl_registry@3.global(16, "weston_screenshooter", 1)
[2996129.176] wl_callback@10.done(43)
[2996129.185]  -> wl_display@1.sync(new id wl_callback@10)
[2996129.214] wl_display@1.delete_id(10)
[2996129.234] wl_shm@11.format(0)
[2996129.239] wl_shm@11.format(1)
[2996129.243] wl_callback@10.done(43)
libEGL debug: DRI2: dlopen(/usr/lib/dri/swrast_dri.so)
libEGL debug: found extension `DRI_Core\'
libEGL info: found extension DRI_Core version 2
libEGL debug: found extension `DRI_SWRast\'
libEGL info: found extension DRI_SWRast version 4
libEGL debug: found extension `DRI_CopySubBuffer\'
libEGL debug: found extension `DRI_ConfigOptions\'
libEGL debug: found extension `DRI_TexBuffer\'
libEGL info: found extension DRI_TexBuffer version 2
libEGL debug: found extension `DRI_RENDERER_QUERY\'
libEGL debug: found extension `DRI_CONFIG_QUERY\'
libEGL debug: found extension `DRI2_Fence\'
libEGL debug: found extension `DRI_NoError\'
libEGL debug: found extension `DRI_IMAGE\'
libEGL debug: found extension `DRI_FlushControl\'
libEGL debug: found extension `DRI_TexBuffer\'
libEGL debug: found extension `DRI_RENDERER_QUERY\'
libEGL info: found extension DRI_RENDERER_QUERY version 1
libEGL debug: found extension `DRI_CONFIG_QUERY\'
libEGL info: found extension DRI_CONFIG_QUERY version 1
libEGL debug: found extension `DRI2_Fence\'
libEGL info: found extension DRI2_Fence version 2
libEGL debug: found extension `DRI_NoError\'
libEGL info: found extension DRI_NoError version 1
libEGL debug: found extension `DRI_IMAGE\'
libEGL info: found extension DRI_IMAGE version 6
libEGL debug: found extension `DRI_FlushControl\'
libEGL info: found extension DRI_FlushControl version 1
libEGL debug: did not find optional extension DRI_Robustness version 1
libEGL debug: did not find optional extension DRI2_Interop version 1
libEGL debug: No DRI config supports native format XRGB2101010
libEGL debug: No DRI config supports native format ARGB2101010
libEGL debug: No DRI config supports native format RGB565
libEGL debug: the best driver is DRI2
PASS   : tst_QOpenGLWindow::initTestCase()
[2996191.142]  -> wl_compositor@4.create_surface(new id wl_surface@10)
[2996191.349]  -> wl_registry@2.bind(12, "zxdg_shell_v6", 1, new id [unknown]@12)
QDEBUG : tst_QOpenGLWindow::readPixels() Using the \'xdg-shell-v6\' shell integration
[2996191.409]  -> zxdg_shell_v6@12.get_xdg_surface(new id zxdg_surface_v6@13, wl_surface@10)
[2996191.431]  -> zxdg_surface_v6@13.get_toplevel(new id zxdg_toplevel_v6@14)
[2996191.457]  -> zxdg_toplevel_v6@14.set_title("tst_qopenglwindow")
[2996191.487]  -> zxdg_toplevel_v6@14.set_app_id("tst_qopenglwindow")
[2996191.498]  -> wl_surface@10.set_buffer_scale(1)
[2996191.525]  -> wl_surface@10.set_buffer_transform(0)
[2996191.533]  -> wl_surface@10.commit()
[2996197.162]  -> wl_compositor@4.create_surface(new id wl_surface@15)
QDEBUG : tst_QOpenGLWindow::readPixels() void QtWaylandClient::QWaylandGLContext::updateGLFormat() wl_egl_window_create 2x2
libEGL debug: mincore failed: Cannot allocate memory
[2996199.567]  -> wl_shm@11.create_pool(new id wl_shm_pool@16, fd 8, 16)
[2996199.584]  -> wl_shm_pool@16.create_buffer(new id wl_buffer@17, 0, 2, 2, 8, 1)
[2996199.609]  -> wl_shm_pool@16.destroy()
[2996199.753]  -> wl_buffer@17.destroy()
QDEBUG : tst_QOpenGLWindow::readPixels() void QtWaylandClient::QWaylandGLContext::updateGLFormat() wl_egl_window_destroy
[2996199.821]  -> wl_surface@15.destroy()
QDEBUG : tst_QOpenGLWindow::readPixels() void QtWaylandClient::QWaylandEglWindow::updateSurface(bool) wl_egl_window_create QSize(4, 4)
libEGL debug: mincore failed: Cannot allocate memory
[2996200.670] zxdg_toplevel_v6@14.configure(0, 0, array)
[2996200.692] zxdg_surface_v6@13.configure(44)
[2996200.715]  -> zxdg_surface_v6@13.ack_configure(44)
QDEBUG : tst_QOpenGLWindow::readPixels() paint 0 pixel 0 "0xff0000ff"
QDEBUG : tst_QOpenGLWindow::readPixels() paint 0 pixel 1 "0xaaaaaaaa"
FAIL!  : tst_QOpenGLWindow::readPixels() Compared values are not the same
   Actual   (pixels[i]) : 2863311530
   Expected (0xff0000ff): 4278190335
   Loc: [/home/johan/dev/qt/11/qtbase/tests/auto/gui/kernel/qopenglwindow/tst_qopenglwindow.cpp(92)]
[2996202.052]  -> wl_shm@11.create_pool(new id wl_shm_pool@18, fd 8, 64)
[2996202.080]  -> wl_shm_pool@18.create_buffer(new id wl_buffer@19, 0, 4, 4, 16, 1)
[2996202.108]  -> wl_shm_pool@18.destroy()
[2996202.114]  -> wl_surface@10.frame(new id wl_callback@20)
[2996202.123]  -> wl_surface@10.attach(wl_buffer@19, 0, 0)
[2996202.133]  -> wl_surface@10.damage(0, 0, 2147483647, 2147483647)
[2996202.150]  -> wl_surface@10.commit()
[2996212.290] wl_display@1.delete_id(16)
[2996212.302] wl_display@1.delete_id(17)
[2996212.306] wl_display@1.delete_id(15)
[2996212.311] wl_display@1.delete_id(18)
[2996212.315] wl_display@1.delete_id(20)
[2996212.319] wl_surface@10.enter(wl_output@8)
FAIL!  : tst_QOpenGLWindow::readPixels() \'(w.paintCount >= 5)\' returned FALSE. ()
   Loc: [/home/johan/dev/qt/11/qtbase/tests/auto/gui/kernel/qopenglwindow/tst_qopenglwindow.cpp(104)]
[3011376.893]  -> zxdg_toplevel_v6@14.destroy()
[3011376.928]  -> zxdg_surface_v6@13.destroy()
[3011376.952]  -> wl_surface@10.destroy()
QDEBUG : tst_QOpenGLWindow::readPixels() virtual void QtWaylandClient::QWaylandEglWindow::invalidateSurface() eglDestroySurface 0x55e46441d750
[3011377.063]  -> wl_buffer@19.destroy()
QDEBUG : tst_QOpenGLWindow::readPixels() virtual void QtWaylandClient::QWaylandEglWindow::invalidateSurface() wl_egl_window_destroy 0x55e46441d750
[3011377.385]  -> wl_compositor@4.create_surface(new id wl_surface@20)
[3011377.580]  -> wl_surface@20.destroy()
PASS   : tst_QOpenGLWindow::cleanupTestCase()
Totals: 2 passed, 2 failed, 0 skipped, 0 blacklisted, 15259ms
********* Finished testing of tst_QOpenGLWindow *********
[3011380.736]  -> wl_shm_pool@9.destroy()'
//    TextArea {
//        anchors.fill: parent
//        text: window.log
//    }

    ScrollView {
        id: objectsView
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: parent.width / 2
        Column {
            width: objectsView.width
            Repeater {
                model: objects
                Label {
                    text: interfaceName + "@" + id
                    color: colorHash(uniqueId)
                }
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
                            anchors.right: parent.right
                            height: 25
                            spacing: 5
                            ObjectLabel { object: parts.object }
                            Label { text: parts.fn }
                            Label { text: "(" }
                            Repeater {
                                model: parts.args
                                ArgumentItem { arg: parts.args[index] }
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
                            ObjectLabel { object: parts.object }
                            Label { text: parts.fn }
                            Label { text: "(" }
                            Repeater {
                                model: parts.args
                                ArgumentItem { arg: parts.args[index] }
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

    function parseArgs(args) {
        // let's do it the shitty way and just split on comma
        return args.split(', ').map(function(arg) {
            return parseNewId(arg) || parseObject(arg) || { type: "unknown", rawText: arg };
        });
    }

    function parseObject(object) {
        const parts = object.match(re.object);
        if (!parts)
            return;
        return { type: "object", interfaceName: parts[1], id: parts[2], rawText: object };
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
        const  lines = log.split('\n');
        state = Lodash._.reduce(lines, function(state, line, lineNumber) {
            const parsedLine = parseLine(line);
            state.parsedLines.push(parsedLine);

            //easier access
            const type = parsedLine.type;
            const parts = parsedLine.parts;
            const object = parts && parts.object;
            const fn = parts && parts.fn;
            const args = parts && parts.args;

            if (type === "event" && object.interfaceName === "wl_registry" && fn === "global") {
                console.log("updating globals", JSON.stringify(args));
                //TODO
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
        }, {parsedLines: [], objects: {}, liveObjectsById: {}, globals: {}});

        // add the lines to a model Qt understands
        state.parsedLines.forEach(function(line) {
            parsedLines.append(line);
        });

        // and the objets
        Lodash._.forEach(state.objects, function(object) {
            objects.append(object);
        });
    }
    Component.onCompleted: parseLog(log)
}
