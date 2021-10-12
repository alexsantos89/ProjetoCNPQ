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
    property string mTitle: "Verificação dos parâmetros de Projeto para Calha Parshall (gradiente de velocidade, número de Froude e Tempo de Mistura)"

    function replaceDecimal(textField) {
        return parseFloat(textField.text.replace(",","."))
    }

    function calculoHa(vazao, k, n) {
        var lala =  (k * Math.pow(vazao, n)).toFixed(2).toString().replace(".",",")
        return lala
    }

    function calculoDlinha(d, w) {
        var lala =  ((2/3)*(d-w) + w).toFixed(4).toString().replace(".",",")
        return lala
    }

    function calculoVa(vazao, dLinha, Ha) {
        var lala =  (vazao / (dLinha*Ha)).toFixed(2).toString().replace(".",",")
        return lala
    }

    function calculoEa(Ha, Va, n) {
        //TODO faltando um parametro na formula a ser confirmado
        var lala =  (Ha + Math.pow(Va, 2) / 2 + n).toFixed(2).toString().replace(".",",")
        return lala
    }

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
                    source: "qrc:/imagens/dimensaoETA2.png"

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

        ScrollView {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            clip: true
            Layout.preferredWidth: 1900

            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            GridLayout {
                id: scrollableColumn
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                columns: 2
                rowSpacing: 30
                columnSpacing: 30
                //Layout.fillWidth: true
                clip: true
                anchors.fill: parent

                GroupBox {
                    id: groupBox

                    title: "Seção de cálculo 1 - altura da lâmina líquida (Ha, em metros): "
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: imagesBox1.implicitWidth / 2

                    ColumnLayout{
                        //anchors.verticalCenter: parent.verticalCenter
                        spacing: 10

                        Label { text: "Passo 1 - Inserir valor da vazão (m^3):" }

                        TextField {
                            id:vazaoText
                            placeholderText: "Vazão (m^3)"
                            //TODO define locale no validator
                            //validator: DoubleValidator{bottom: 0.85 ; top: 3950.0 ; decimals: 2}
                        }

                        Label { text: "Passo 2 - Utilize o K e n sugerido em outra seção ou selecione um W (ver tabela 2):" }
                        Button {
                            id: alteraW
                            text:"Alterar W"
                            onClicked: {
                                vazaoDialog.filtered = false
                                vazaoDialog.open()
                            }
                        }
                        TextField { id: kText ; placeholderText: "K" ; enabled: false ; validator: DoubleValidator{}}
                        TextField { id: nText ; placeholderText: "n" ; enabled: false ; validator: DoubleValidator{}}

                        Label { text: "Formula: Ha = K*Q^n" }

                        Button {
                            id: calculaHa
                            text:"Clique aqui"
                            enabled: vazaoText.acceptableInput && kText.acceptableInput && nText.acceptableInput
                            onClicked: {
                                haResultadoText.text = calculoHa(replaceDecimal(vazaoText),replaceDecimal(kText),replaceDecimal(nText))
                            }
                        }

                        Label { text: "Resultado Ha (m):" ; visible: true }
                        TextField { id: haResultadoText ; enabled: false ; readOnly: true ; visible: true ; validator: DoubleValidator{} }

                    }
                }

                GroupBox {

                    title: "Seção de cálculo 2 - Largura da seção de medida (D, em metros)"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.preferredWidth: imagesBox1.implicitWidth / 2

                    ColumnLayout{
                        spacing: 10

                        Label { text: "Passo 1 - Selecione um W e o respectivo D (ver tabela 1):" }
                        Button {
                            id: alteraW2
                            text:"Alterar W"
                            onClicked: {
                                vazaoDialog.filtered = false
                                vazaoDialog.open()
                            }
                        }
                        TextField { id: wText ; placeholderText: "W" ; enabled: false ; readOnly: true ; validator: DoubleValidator{}}
                        TextField { id: dText ; placeholderText: "D" ; enabled: false ; readOnly: true ; validator: DoubleValidator{}}
                        Label { text: "Formula: D' = (2/3)*(D-W) + W" }
                        Button {
                            text: "Calcular"
                            enabled: wText.acceptableInput && dText.acceptableInput
                            onClicked: dLinhaResultadoText.text = calculoDlinha(replaceDecimal(dText), replaceDecimal(wText))
                        }
                        Label { text: "Resultado D' (m):" ; visible: true }
                        TextField { id: dLinhaResultadoText ; enabled: false ; readOnly: true ; visible: true ; validator: DoubleValidator{} }
                    }
                }

                GroupBox {

                    title: "Seção de cálculo 3 - velocidade na seção de medida (Va, em metros por segundo): "
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout {
                        //anchors.verticalCenter: parent.verticalCenter
                        spacing: 10

                        Button {
                            text: "Copia anteriores"
                            onClicked: function() {
                                vazaoText2.text = vazaoText.text
                                dText2.text = dLinhaResultadoText.text
                                haText2.text = haResultadoText.text
                            }
                        }

                        Label { text: "Passo 1 - Inserir valor da vazão (m^3):" }

                        RowLayout{
                            TextField {
                                id:vazaoText2
                                placeholderText: "Vazão (m^3)"
                            }
                        }

                        Label { text: "Passo 2 - Utilize o D' e Ha calculado:" }

                        TextField { id: dText2 ; placeholderText: "D'" ; enabled: true ; validator: DoubleValidator{}}
                        TextField { id: haText2 ; placeholderText: "Ha" ; enabled: true ; validator: DoubleValidator{}}

                        Label { text: "Formula: Va = Q/(D'*Ha)" }

                        Button {
                            id: calculaVa
                            text:"Clique aqui"
                            enabled: vazaoText2.acceptableInput && dText2.acceptableInput && haText2.acceptableInput
                            onClicked: {
                                vaResultadoText.text =  calculoVa(replaceDecimal(vazaoText2),replaceDecimal(dText2),replaceDecimal(haText2))
                            }
                        }

                        Label { text: "Resultado Va (m/s):" ; visible: true }
                        TextField { id: vaResultadoText ; enabled: false ; readOnly: true ; visible: true ; validator: DoubleValidator{} }

                    }
                }

                GroupBox {

                    title: "Seção de cálculo 4 - energia total disponível (Ea, em metros): "
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout {
                        spacing: 10

                        Button {
                            text: "Copia anteriores"
                            onClicked: function() {
                                vaText2.text = vaResultadoText.text
                                haText3.text = haResultadoText.text
                            }
                        }

                        Label { text: "Passo 1 - Utilize Ha e Va calculado:" }

                        TextField { id: haText3 ; placeholderText: "Va" ; enabled: true ; validator: DoubleValidator{}}
                        TextField { id: vaText2 ; placeholderText: "Ha" ; enabled: true ; validator: DoubleValidator{}}

                        Label { text: "Passo 2 - Selecione um W e o respectivo N (ver tabela 1):" }
                        Button {
                            text:"Alterar W"
                            onClicked: {
                                vazaoDialog.filtered = false
                                vazaoDialog.open()
                            }
                        }
                        TextField { id: medNText ; placeholderText: "N" ; enabled: false ; readOnly: true ; validator: DoubleValidator{}}

                        Label { text: "Formula: Ea = Ha + Va^2/2g + N)" }

                        Button {
                            text:"Clique aqui"
                            enabled: vaText2.acceptableInput && haText3.acceptableInput && medNText.acceptableInput
                            onClicked: {
                                eaResultadoText.text =  calculoEa(replaceDecimal(haText3),replaceDecimal(vaText2),replaceDecimal(medNText))
                            }
                        }

                        Label { text: "Resultado Ea (m):" ; visible: true }
                        TextField { id: eaResultadoText ; enabled: false ; readOnly: true ; visible: true ; validator: DoubleValidator{} }

                    }
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
        wText: wText
        dText: dText
        medNText: medNText
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
