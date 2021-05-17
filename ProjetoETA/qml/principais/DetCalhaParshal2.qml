import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import QtQml 2.12
import "../popups"
import "../views"
import xyz.aahome89.base 1.0

Item {

    id: detCalhaParshal2
    property StackView mStack
    property string mTitle: "Verificação dos parâmetros de Projeto para Calha Parshall (gradiente de velocidade, número de Froude e Tempo de Mistura)"

    ColumnLayout {

        id: mainColumn
        anchors.fill: parent
        anchors.margins: 11

        GroupBox {
            id: imagesBox1
            Layout.fillWidth: true
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
            }
        }


        RowLayout {
            id: rowLayout

            GroupBox {
                id: groupBox

                title: "Seção de cálculo 1 - determinação da garganta (W)"
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: imagesBox1.implicitWidth / 2

                ColumnLayout{
                    //anchors.verticalCenter: parent.verticalCenter
                    spacing: 10

                    ToolTip.delay: 1000
                    ToolTip.timeout: 5000
                    ToolTip.visible: hovered
                    ToolTip.text: "Botão só é habilitado após uma vazão válida ser digitado no Passo 1 (Tabela 2)"

                    Label { text: "Passo 1 - Inserir valor da vazão (L/s):" }

                    TextField {
                        id:vazaoText
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

                    Label { text: "Conforme a calha selecionada, as dimensões em centimetros são: " }

                    CalhaGridview {
                        id: calhaView
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                    }

                }
            }

            GroupBox {

                title: "Seção de cálculo 2 - cálculo da vazão"
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.preferredWidth: imagesBox1.implicitWidth / 2

                ColumnLayout{
                    spacing: 10

                    Label { text: "Passo 1 - Inserir altura da lâmina líquida (Ha) em metros:" }
                    RowLayout{
                        TextField { id: haText ; placeholderText: "Ha (m)" ; enabled: !vazaoHandler.parsed ; validator: DoubleValidator{decimals: 2} }
                        Label { text: "ou" }
                        Button {
                            id: abreCSV
                            text: vazaoHandler.parsed ? "Reset" : "Upload CSV"
                            onClicked: function() {
                                if (vazaoHandler.parsed) {
                                    vazaoHandler.reset()
                                } else {
                                    fileDialog.selectExisting = true
                                    fileDialog.open()
                                }
                            }
                        }
                    }
                    Label { text: "Passo 2 - Utilize o K e n sugerido da seção 1 ou selecione outro W (ver tabela 2):" }
                    Button {
                        id: alteraW
                        text:"Alterar W"
                        onClicked: {
                            vazaoDialog.filtered = false
                            vazaoDialog.open()
                        }
                    }
                    TextField { id: kText ; placeholderText: "K" ; enabled: false ; readOnly: true ; validator: DoubleValidator{}}
                    TextField { id: nText ; placeholderText: "n" ; enabled: false ; readOnly: true ; validator: DoubleValidator{}}
                    Label { text: "Passo 3 - Aperte o botão para calcular:" }
                    Button {
                        text: vazaoHandler.parsed ? "Exportar CSV" : "Calcular"
                        enabled: (haText.acceptableInput || vazaoHandler.parsed ) && kText.acceptableInput && nText.acceptableInput
                        onClicked: function() {
                            if (vazaoHandler.parsed) {
                                fileDialog.selectExisting = false
                                fileDialog.open()
                            } else {
                                //vazaoResultadoText.text = (parseFloat(haText.text) / (parseFloat(kText.text) * parseFloat(nText.text))).toFixed(2)
                                vazaoResultadoText.text = vazaoHandler.calculo_vazao(parseFloat(haText.text.replace(",","."))).toFixed(2)
                            }
                        }
                    }
                    Label { text: "Resultado da vazão (L/s):" ; visible: !vazaoHandler.parsed }
                    TextField { id: vazaoResultadoText ; enabled: false ; readOnly: true ; visible: !vazaoHandler.parsed ; validator: DoubleValidator{} }
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
        calhaView: calhaView
        vazaoHandler: vazaoHandler
    }

    FileDialog {
        id: fileDialog
        nameFilters: ["CSV files (*.csv)"]
        onAccepted: {
            if (fileDialog.selectExisting)
                vazaoHandler.fileUrl = fileUrl
            else
                vazaoHandler.saveAs(fileUrl, selectedNameFilter)
        }
    }

    CSVVazaoHandler {
        id: vazaoHandler
        onParsedChanged: function(msg,error) {
            if (msg.length != 0)
            {
                popup.msg = msg
                popup.error = error
                popup.open()
            }
        }
    }

    AlertPopup2 {
        id: popup
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
