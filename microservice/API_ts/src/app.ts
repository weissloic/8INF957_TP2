import config from "./config"
import express from "express"
import {Routes} from "./routes/routes";
import {Express} from "express";


class App {
    public app: Express;
    public route: Routes;


    constructor() {
        this.app = express();
        this.route = new Routes();
    }

    public async start() {
        this.app.listen( config.port, () => {
            console.log("Server running on port : " + config.port);
            this.route.routes(this.app);
        });
    }
}

new App().start();