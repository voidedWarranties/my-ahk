const express = require("express");
const robot = require("robotjs");
const app = express();
const port = 80;

var isCtrlDown = false;
var isAltDown = false;
var isShiftDown = false;
var isWinDown = false;

app.post("/", (req, res) => {
    var modkey = "";
    switch(req.query.device) {
        case "/dev/Macros1":
            modkey = "f23";
            break;
        case "/dev/Macros2":
            modkey = "f24";
            break;
    }
    if(req.query.key && req.query.state == 1) {
        var key = req.query.key.replace("KEY_", "").toLowerCase();

        var isCtrlDownNow = key == "leftctrl" || key == "rightctrl";
        var isAltDownNow = key == "leftalt" || key =="rightalt";
        var isShiftDownNow = key == "leftshift" || key =="rightshift";
        var isWinDownNow = key == "leftmeta" || key =="rightmeta";

        if(isCtrlDownNow) isCtrlDown = true;
        if(isAltDownNow) isAltDown = true;
        if(isShiftDownNow) isShiftDown = true;
        if(isWinDownNow) isWinDown = true;

        if(!isCtrlDownNow && !isAltDownNow && !isShiftDownNow && !isWinDownNow) {
            robot.keyToggle(modkey, "down");
            if(isCtrlDown) robot.keyToggle("control", "down");
            if(isAltDown) robot.keyToggle("alt", "down");
            if(isShiftDown) robot.keyToggle("shift", "down");
            if(isWinDown) robot.keyToggle("command", "down");
            robot.keyToggle(key, "down");
            robot.keyToggle(key, "up");
            if(isWinDown) robot.keyToggle("command", "up");
            if(isShiftDown) robot.keyToggle("shift", "up");
            if(isAltDown) robot.keyToggle("alt", "up");
            if(isCtrlDown) robot.keyToggle("control", "up");
            robot.keyToggle(modkey, "up");
        }
    }

    if(req.query.state == 0) {
        var key = req.query.key.replace("KEY_", "").toLowerCase();
        if(key == "leftctrl" || key == "rightctrl") isCtrlDown = false;
        if(key == "leftalt" || key =="rightalt") isAltDown = false;
        if(key == "leftshift" || key =="rightshift") isShiftDown = false;
        if(key == "leftmeta" || key =="rightmeta") isWinDown = false;
    }
    res.json({status: 200});
});

app.listen(port, "0.0.0.0", () => console.log("OK"));