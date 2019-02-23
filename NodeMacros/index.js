const express = require("express");
const robot = require("robotjs");
const app = express();
const port = 80;

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
        var key = req.query.key.replace("KEY_", "");
        robot.keyToggle(modkey, "down");
        robot.keyToggle(key, "down");
        robot.keyToggle(key, "up");
        robot.keyToggle(modkey, "up");
    }
    res.json({status: 200});
});

app.listen(port, "0.0.0.0", () => console.log("OK"));