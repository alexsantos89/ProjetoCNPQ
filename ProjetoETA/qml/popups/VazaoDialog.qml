import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../models"
import "../principais"
import "../views"
import xyz.aahome89.base 1.0

Dialog {

    id: vazaoDialog
    title: "Selecione a garganta (W) desejada"
    modal: true
    width: 540
    height: 300
    standardButtons: DialogButtonBox.Ok | DialogButtonBox.Cancel

    property TextField vazaoText
    property TextField kText
    property TextField nText
    property TextField wText
    property TextField dText
    property bool filtered
    property CalhaGridview calhaView
    property CSVVazaoHandler vazaoHandler

    onAccepted: function() {
        //TODO define locale para transformar de ponto para virgula (talvez so precisa trocar . por ,)
        kText.text = vazaoListView.currentItem.myData.k
        nText.text = vazaoListView.currentItem.myData.n
        vazaoHandler.k = vazaoListView.currentItem.myData.k
        vazaoHandler.n = vazaoListView.currentItem.myData.n
        if (wText !== null) {
            wText.text = vazaoListView.currentItem.myData.w / 1000
            dText.text = (vazaoListView.currentItem.myData.medD / 100).toFixed(3)
        }
        if (vazaoDialog.filtered){
            calhaView.myData = vazaoListView.currentItem.myData
            calhaView.updateModel()
        }
    }

    onRejected: vazaoDialog.close()

    onVisibleChanged: function (){
        if (vazaoDialog.visible)
            createModel(vazaoDialog.filtered)
    }

    header: Label {text: "Selecione a Garganta (mm) desejada" ; font.bold: true; leftPadding: 10 ; topPadding: 10 }

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
            model: myModel
            clip: true
            highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
            focus: true

            delegate: ItemDelegate {

                property variant myData: model

                onClicked: ListView.view.currentIndex = index

                contentItem: ColumnLayout{
                    width: parent.width - 20
                    spacing: 0
                    Label {text: "Garganta (W) de " + w + " mm" }
                }
            }

            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AlwaysOn }
        }
    }

    function createModel(filtered = false){
        myModel.clear()
        for(var i=0;i<vazaoModel.count; i++)
            if(filtered){
                if(vazaoModel.get(i).vazaoMin <= parseFloat(vazaoText.text.replace(",",".")) && vazaoModel.get(i).vazaoMax >= parseFloat(vazaoText.text.replace(",",".")))
                    myModel.append(vazaoModel.get(i))
            } else {
                myModel.append(vazaoModel.get(i))
            }
    }

    ListModel {
        id: myModel
    }

    VazaoModel {
        id: vazaoModel
    }

}
