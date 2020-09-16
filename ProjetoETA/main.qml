import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12


ApplicationWindow {
    visible: true
    minimumHeight: 768
    minimumWidth: 1024

    //Define o titulo da janela principal
    title: "Projeto ETA"

    //Definicao de todas as acoes (TODO: criar objetos dinamicamente usando javascript https://doc.qt.io/qt-5/qtqml-javascript-dynamicobjectcreation.html)

    Action {
        id: detCalhaParshalAction
        text: "Calha Parshall"
        onTriggered: {
            mainStack.push("qrc:/qml/principais/DetCalhaParshal.qml", { mStack: mainStack });
            //toolbarTitle.text = "Det. Calha Parshal";
        }
    }

    //Criacao do menubar da janela principal
    menuBar: MenuBar {
        Menu {
            title: "&Menu"
            MenuItem { action: detCalhaParshalAction }
            MenuSeparator {}
            MenuItem { text: "Sair"; onTriggered: Qt.quit() }
        }
    }


    //Define o footer e header da pagina
    header: ToolBar {

        ToolButton {
            text: "Voltar"
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            enabled: mainStack.depth > 1
            onClicked: mainStack.pop()
        }

        Label {
            id: toolbarTitle
            text: "Inicial"
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    //Stack da janela principal
    StackView {
        id: mainStack
        initialItem: mainView
        anchors.fill: parent

        onCurrentItemChanged: {
            toolbarTitle.text = currentItem.mTitle
        }

    }

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

}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
