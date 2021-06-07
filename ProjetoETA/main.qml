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

    function setCurrentTitle() {
        var loaded
        for( var i = 0 ; i < mainRepeater.count ; i++) {
            try {
                if ( mainRepeater.itemAt(i).item.visible ) {
                    loaded = mainRepeater.itemAt(i).item;
                    break;
                }
            } catch (error) {
                console.log(error);
            }
        }
        console.log(loaded.mTitle);
        toolbarTitle.text = loaded.mTitle
    }

    Action {
        id: detCalhaParshalAction
        text: "Calha Parshall"
        onTriggered: {
            currentPage = 'DetCalhaParshal'
        }
    }

    Action {
        id: detCalhaParshalAction2
        text: "Calha Parshall 2"
        onTriggered: {
            currentPage = 'DetCalhaParshal2'
        }
    }

    //Criacao do menubar da janela principal
    menuBar: MenuBar {
        Menu {
            title: "&Menu"
            MenuItem { action: detCalhaParshalAction }
            MenuItem { action: detCalhaParshalAction2 }
            MenuSeparator {}
            MenuItem { text: "Sair"; onTriggered: Qt.quit() }
        }
    }


    //Define o footer e header da pagina
    header: ToolBar {

//        ToolButton {
//            text: "Voltar"
//            anchors.left: parent.left
//            anchors.leftMargin: 10
//            anchors.verticalCenter: parent.verticalCenter
//            enabled: mainStack.depth > 2
//            onClicked: {
//                var item1 = mainStack.pop();
//                var item2 = mainStack.pop();
//                mainStack.push(item1);
//                mainStack.push(item2);
//            }
//        }

        Label {
            id: toolbarTitle
            text: "Inicial"
            font.pixelSize: 20
            anchors.centerIn: parent
        }
    }

    // Put the name of the QML files containing your pages (without the '.qml')
    property variant pagesList  : [
        "MainView",
        "DetCalhaParshal",
        "DetCalhaParshal2"
    ];

    // Set this property to another file name to change page
    property string  currentPage : "MainView";

    Repeater {
        id: mainRepeater
        model: pagesList;
        delegate: Loader {
            active: false;
            asynchronous: false;
            anchors.fill: parent;
            visible: (currentPage === modelData);
            source: "qrc:/qml/principais/%1.qml".arg(modelData)
            onVisibleChanged:      { loadIfNotLoaded(); setCurrentTitle() }
            Component.onCompleted: { loadIfNotLoaded(); setCurrentTitle() }

            function loadIfNotLoaded () {
                // to load the file at first show
                if (visible && !active) {
                    active = true;
                }
            }
        }
    }

}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
