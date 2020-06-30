import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../models"
import "../principais"

Dialog {

    id: vazaoDialog
    title: "Selecione a garganta (W) desejada"
    modal: true
    width: 540
    height: 300
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property TextField vazaoText
    property TextField kText

    onAccepted: kText.text = "fdsa"

    onRejected: vazaoDialog.close()

    header: Label {text: "Selecione a Garganta (mm) desejada" ; leftPadding: 10}

    contentItem: ColumnLayout{

        id: mainLayout
        anchors.top: parent.header.bottom
        anchors.bottom: parent.footer.top
        anchors.left: parent.Left
        anchors.right: parent.Right
        //Layout.fillWidth: true


        ListView {

            id: vazaoListView
            anchors.fill: parent
            anchors.margins: 11
            verticalLayoutDirection: ListView.TopToBottom
            model: VazaoModel {}
            clip: true
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true

            delegate: ItemDelegate {

                onClicked: ListView.view.currentIndex = index

                contentItem: ColumnLayout{
                    width: parent.width - 20
                    spacing: 0
                    Label { text: "Garganta (W) de " + w + " mm" }
                }
            }

            ScrollBar.vertical: ScrollBar {}
        }
    }

}
