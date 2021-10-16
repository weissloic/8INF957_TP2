import {Express, NextFunction, Router} from "express";
import {UserController} from "../controller/user.controller";

export class Routes {

    public routes(app: Express): void {
        /**
         *  @swagger
         * /customers:
         *  get:
         *    description: Use to request an HelloWorld Json
         *    responses:
         *      '200':
         *        description: A successful response
         *      '500':
         *        description: internal server error
         *
         */
        app.route("/helloworld").get(UserController.HelloWorld);
        app.route("/weather").get(UserController.fetchData);
    }
}
