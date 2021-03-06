import config from "../config"
import axios from "axios"


export class UserService {

    static async fetchWeather(): Promise<any> {
        return axios.get(`https://api.openweathermap.org/data/2.5/weather`,
        {
            params: {
                q: "Paris",
                appid: config.key
            }
        }).then(res => {console.log(res.data) ; return res.data}).catch(err => {console.log("error in fetWeather");console.log(err)});
    }

    static async createUser() : Promise<any> {

        return axios.post(`http://api2:8083/user`,
            {
                    email: "toto",
                    name: "toto",
                    password: "toto"
            }
            ).then(res => {console.log(res.data) ; return res.data}).catch(err => {console.log("error in createUser request"); console.log(err)});
    }
}