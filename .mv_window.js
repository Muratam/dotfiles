function show(x) { console.log(Automation.getDisplayString(x)) }
function showByApp(text) {
    app = Application.currentApplication()
    app.includeStandardAdditions = true
    app.displayDialog(Automation.getDisplayString(text))
}
function getDockInfo() {
    apps = Application("System Events").processes()
    for (app of apps) {
        if (app.name() != "Dock") continue
        return app.uiElements()[0].uiElements().map(function (x) {return x.name() })
    }
}

function getFrontWindow() {
    apps = Application("System Events").processes()
    for (app of apps) {
        if (app.frontmost()) return app.windows[0]
    }
}

function getDesktopBounds() {
    return Application("Finder").desktop().window().bounds()
}
function setWindowRect(window,x,y,w,h) {
    width = getDesktopBounds()["width"]
    height = getDesktopBounds()["height"]
    window.position = [x*width,y*height]
    window.size = [w*width,h*height]
}
function toggleActivateApplication(name) {
    app = Application(name)
    if (app.frontmost()) {
        Application("System Events").keyCode(48,{using:"command down"})
    } else {
        if(name !== "iTunes")app.launch()
        app.activate()
    }
}
function keyMove(mv) {
    window = getFrontWindow()
    setWindowRect(window, mv[0], mv[1], mv[2], mv[3])
}
function switchApp() {
    x = getFrontWindow().position()[0]
    w = getDesktopBounds()["width"]
    h = getDesktopBounds()["height"]
    nx = w/4 * (x < w / 2 - 100 ? 3 : 1)
    app = Application.currentApplication()
    app.includeStandardAdditions = true
    app.doShellScript("/usr/local/bin/cliclick c:" + nx + "," + (h / 2))
}
keyMovements = {
    L: [0, 0, 0.5, 1],
    R: [0.5, 0, 0.5, 1],
    UL: [0, 0, 0.5, 0.5],
    UR: [0.5, 0, 0.5, 0.5],
    DL: [0, 0.5, 0.5, 0.],
    DR: [0.5, 0.5, 0.5, 0.5],
    MAX: [0, 0, 1, 1],
}
function run(input, parameters) {
    if (input.length > 0) {
        if (input[0] in keyMovements) {
            keyMove(keyMovements[input[0]])
        } else {
            if (isNaN(Number(input[0]))) {
                toggleActivateApplication(input[0])
            } else {
                docks = getDockInfo()
                if (Number(input[0]) < docks.length) {
                    toggleActivateApplication(docks[Number(input[0])])
                }
            }
        }
    } else {
        switchApp();
    }
}
