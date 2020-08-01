import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

MessageDialog {
    id: messageDialog

    property string msg
    property bool error: false

    title: "Alerta"
    icon: error ? StandardIcon.Warning : StandardIcon.Information
    text: msg

}
