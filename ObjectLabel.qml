import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import "./lodash.js" as Lodash

Label {
    property var object
    text: object.interfaceName + "@" + object.id
    color: object.uniqueId ? colorHash(object.uniqueId) : "gray"
}
