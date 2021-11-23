package api.v1.Controller;

import api.v1.model.User;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class UserController {

    @PostMapping("/user")
    String newUser(@RequestBody User newUser) {

        System.out.println("PASS");
        return newUser.toString();
    }

}