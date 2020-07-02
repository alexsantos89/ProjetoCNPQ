import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {

    id: calhaView

    property variant myData

    GridLayout {

        rows: 1
        flow: GridLayout.TopToBottom

        Label { id: medA ; text: "A: " }
        Label { id: medB ; text: "B: " }
        Label { id: medC ; text: "C: " }

        Label { id: medD ; text: "D: " }
        Label { id: medE ; text: "E: " }
        Label { id: medF ; text: "F: " }

        Label { id: medG ; text: "G: " }
        Label { id: medK ; text: "K: " }
        Label { id: medN ; text: "N: " }

    }

    function updateModel(){
        medA.text = "A: " + myData.medA
        medB.text = "B: " + myData.medB
        medC.text = "C: " + myData.medC
        medD.text = "D: " + myData.medD
        medE.text = "E: " + myData.medE
        medF.text = "F: " + myData.medF
        medG.text = "G: " + myData.medG
        medK.text = "K: " + myData.medK
        medN.text = "N: " + myData.medN
    }

}
