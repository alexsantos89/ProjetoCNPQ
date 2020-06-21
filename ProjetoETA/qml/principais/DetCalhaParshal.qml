import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {

    id: detCalhaParshal
    property StackView mStack
    property string mTitle: "Det. Calha Parshal"

    //TODO: Remover exemplo
   /* RowLayout {

        spacing: 10
        Layout.fillWidth: true

        Button {
            text: "Push"
            onClicked: mStack.push(parent)
        }
        Button {
            text: "Pop"
            enabled: mStack.depth > 1
            onClicked: mStack.pop()

        }
        Text {
            text: mStack.depth
        }
    }*/

    ColumnLayout {
        anchors.centerIn: parent

        Label {
            text: "TODO"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 13
        }
    }

}
