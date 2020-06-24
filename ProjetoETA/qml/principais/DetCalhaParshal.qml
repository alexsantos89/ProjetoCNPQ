import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../popups"

Item {

    id: detCalhaParshal
    property StackView mStack
    property string mTitle: "Determinação Calha Parshal"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 11

        GroupBox {
            id: imagesBox1
            Layout.fillWidth: true
            title: "Figuras Calha Parshal"
            clip: true

            GridLayout{

                id: gridFiguras
                rowSpacing: 30
                columnSpacing: 30
                rows: 2
                flow: GridLayout.TopToBottom
                Layout.fillWidth: true
                clip: true
                anchors.fill: parent

                Image {
                    id: dimensaoETA
                    width: 450 //501
                    height: 300 //308
                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    source: "qrc:/imagens/DimensaoETA.jpg"

                }

                Label {
                    text: "Figura 1 - Dimensões Calha Parshal"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Image {
                    id: tabelaDimensoes
                    width: 450 //501
                    height: 300 //308
                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    source: "qrc:/imagens/tabela_dimensoes.png"

                }

                Label {
                    text: "Figura 2 - Tab. Dimensões Calha Parshal"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Image {
                    id: tabelaVazaoxEspessura
                    width: 450 //501
                    height: 300 //308
                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    source: "qrc:/imagens/tabelaRedimensionada.png"
                }

                Label {
                    text: "Figura 3 - Tabela Vazão X Espessura Garganta"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
            }
        }


        RowLayout {
            id: rowLayout

            GroupBox {
                id: groupBox

                title: "Seção de Cálculo 1"
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout{
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    Label { text: "Passo 1 - Inserir bla bla bla" }
                    TextField { placeholderText: "Inserir Vazão"}
                    Button {
                        text:"Ok"
                        onClicked: vazaoDialog.open()
                    }
                }
            }

            GroupBox {

                title: "Seção de Cálculo 2"
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout{
                    spacing: 10

                    Label { text: "Passo 1 - Inserir bla bla bla" }
                    TextField { placeholderText: "Inserir Vazão"}
                }
            }
        }

    }

    VazaoDialog {
        id: vazaoDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
