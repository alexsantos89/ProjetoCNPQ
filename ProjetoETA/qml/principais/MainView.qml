import QtQuick 2.0

//Principal view da Stack
Item {
    id: mainView
    property string mTitle: "Inicial"

    Text
    {
        text: "Selecione umas das opções no menu acima!"
        font.pointSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.centerIn: parent
    }
}
