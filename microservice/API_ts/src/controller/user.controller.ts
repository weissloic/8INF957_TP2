import {Request, Response} from "express";
import {UserService} from "../service/user.service";

export class UserController {

    public static async HelloWorld(req: Request, res: Response): Promise<void> {
        res.status(200).json({text: "Hello World"});
    }

    public static async fetchData(req: Request, res: Response): Promise<void> {
        UserService.fetchWeather().then(data => res.status(200).json(data)).catch(err => {console.log("error in fetchData");console.log(err);});
    }

}