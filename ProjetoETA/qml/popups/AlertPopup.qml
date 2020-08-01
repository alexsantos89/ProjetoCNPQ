import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Dialog {

    id: popupDialog
    modal: true
    focus: true
    width: 540
    height: 300
    font.pointSize: 14
    title: "Alerta!"
    standardButtons: DialogButtonBox.Ok

    property string msg

    onAccepted: popupDialog.close()

    onRejected: popupDialog.close()

    //header: Label {text: "Selecione a Garganta (mm) desejada" ; font.bold: true; leftPadding: 10 ; topPadding: 10 }

    contentItem: ColumnLayout{

        id: mainLayout
        anchors.top: parent.header.bottom
        anchors.bottom: parent.footer.top
        anchors.left: parent.Left
        anchors.right: parent.Right
        //Layout.fillWidth: true

        Label {text: msg ; font.pointSize: 13; Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter; font.bold: true }

    }

}
