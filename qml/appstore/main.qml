import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Storage


PageStackWindow {
    id: window
    initialPage: MainPage {  }
    showStatusBar: true

    showToolBar: (xmlLoaded) ? (downloading) ? false : (installing) ? false : true : false
    platformInverted: invertedTheme
    property int insMethod:null
    property bool invertedTheme: null
    property string driveSaved: null

    Component.onCompleted: {
        // this happens when xml is being loaded //
        Storage.getDatabase(); // do not remove this
        Storage.initialize(); // do not remove this
        if(Storage.getSetting("firstRun")=="un") {
            console.log("First Run detected.")
            Storage.setSetting("invertedTheme","true")
            invertedTheme = true
            Storage.setSetting("insMeth","1")
            insMethod = 1
            Storage.setSetting("insDrive","C")
            driveSaved = "C"
            Storage.setSetting("firstRun", "false")
        } else {
            invertedTheme =  Storage.getSetting("invertedTheme");
            insMethod = Storage.getSetting("insMeth");
            driveSaved = Storage.getSetting("insDrive")
            console.log("Default Settings loaded")
        }
        dlhelper.path(driveSaved)

    }
    property bool downloading: false
    property bool finished: false
    property bool cancel: false

    property int appCount: 0
    property int headerheight: 70
    property int itemHeight: 80
    property bool xmlLoaded: false
    property bool xmlError: false
    property string cateFilter: ""
    property bool categoriesView: false
    property string searchString: ""
    property bool storeView: true
    property bool catView: false
    property int fieldSpace: (searching) ? 50 : 0
    property bool searching: false
    property bool installing: false
    property string uidGet: ""
    QueryDialog {
        id:closeYesNo
        titleText: "Warning"
        message: "Are you sure do you want to close the Store?"
        acceptButtonText: "Close"
        rejectButtonText: "Back"
        platformInverted: invertedTheme
        onAccepted: {
            Qt.quit()
        }
        onRejected: {
            close();
        }
    }
    ToolBar {
        id:sharedToolBar
        tools: toolBarLayout
        platformInverted: false
    }
    ToolBarLayout {
        id:tlBar
        ToolButton {
            flat:true
            iconSource: "toolbar-back"
            //platformInverted: invertedTheme
            onClicked: {
               /* if(searching==false || cateFilter=="" ) {
                    window.pageStack.pop()
                } else {*/
                    searching=false
                    searchString=""
                    cateFilter=""
                    sharedToolBar.setTools(toolBarLayout)
               // }
            }
        }
    }

    ToolBarLayout {
        id: toolBarLayout
        ToolButton {
            flat: true
            //platformInverted: invertedTheme
            iconSource: "toolbar-back"
            onClicked: {
                if(window.pageStack.depth <= 1) {
                    closeYesNo.open();
                } else {
                    window.pageStack.pop()
                }
                if(searching==true || cateFilter!="") {
                    sharedToolBar.setTools(tlBar)
                }
                console.log(window.pageStack.depth)


            }
        }
        ToolButton {
            flat: true
            //platformInverted: invertedTheme
            iconSource: "toolbar-list"
            onClicked: {
                categoriesView=true

                window.pageStack.push(Qt.createComponent("CategoriesPage.qml"))
               // sharedToolBar.setTools(tlBar)

            }


        }
        ToolButton {
            flat: true
            //platformInverted: invertedTheme
            iconSource: "toolbar-search"
            onClicked: {
                searching=true
                sharedToolBar.setTools(tlBar)
            }
        }
        ToolButton {
            flat: true
            //platformInverted: invertedTheme
            //iconSource:(invertedTheme) ? "ui/settings-inv.svg" : "ui/settings.svg"
            iconSource:"ui/settings.svg"
            onClicked: window.pageStack.push(Qt.resolvedUrl("ConfigPage.qml"))
        }
    }

    Connections {
        id:connector
        target: core
        onCategorieChanged: {
            cateFilter = core.getCatFilterName()
        }
        }
}
