import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../popups"

Item {

    id: detCalhaParshal
    property StackView mStack
    property string mTitle: "Calha Parshall: determinação da garganta (W) e cálculo da vazão"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 11

        GroupBox {
            id: imagesBox1
            Layout.fillWidth: true
            //title: "Figuras Calha Parshal"
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
                    text: "Figura 1 - Dimensões da calha parshall (planta e corte)"
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
                    text: "Tabela 1 - Dimensões da calha parshal"
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
                    text: "Tabela 2 - Vazão x Garganta (W) e valores de K e n"
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
            }
        }


        RowLayout {
            id: rowLayout

            GroupBox {
                id: groupBox

                title: "Seção de cálculo 1 - determinação da garganta (W)"
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout{
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: "Botão só é habilitado após uma vazão válida ser digitado no Passo 1 (Tabela 2)"

                    Label { text: "Passo 1 - Inserir valor da vazão (L/s):" }
                    TextField { id:vazaoText
                        placeholderText: "Vazão (L/s)"

                        //TODO define locale no validator
                        validator: DoubleValidator{bottom: 0.85 ; top: 3950.0 ; decimals: 2}
                    }
                    Label { text: "Passo 2 - Escolha a calha desejada (W):" }
                    Button {
                        id: calculaW
                        text:"Clique aqui"
                        enabled: vazaoText.acceptableInput
                        onClicked: {
                            vazaoDialog.filtered = true
                            vazaoDialog.open()
                        }
                    }
                    Label { text: "Conforme a calha selecionada, as dimensões são: " }
                    //TODO: gerar tabela dinamica com os resultados
                    Item{
                        Layout.fillHeight: true
                    }
                }
            }

            GroupBox {

                title: "Seção de cálculo 2 - cálculo da vazão"
                Layout.fillWidth: true
                Layout.fillHeight: true

                ColumnLayout{
                    spacing: 10

                    Label { text: "Passo 1 - Inserir altura da lâmina líquida (Ha):" }
                    TextField { placeholderText: "Ha (m)"}
                    Label { text: "Passo 2 - Utilize o K e n sugerido da seção 1 ou digite o desejado (ver tabela 2):" }
                    TextField { id: kText ; placeholderText: "K" }
                    TextField { id: nText ; placeholderText: "n"}
                    Label { text: "Passo 3 - Aperte o botão para calcular:" }
                    Button {
                        text:"Calcular"
                    }
                    Label { text: "Resultado da vazão (L/s):" }
                    TextField { }
                }
            }
        }

    }

    VazaoDialog {
        id: vazaoDialog
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        kText: kText
        nText: nText
        vazaoText: vazaoText
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
