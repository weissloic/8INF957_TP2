package api.v1.model;
import java.util.Objects;

public class User {

    private String name;
    private String email;
    private String password;

    User() {}

    User(String name, String email, String password) {

        this.name = name;
        this.email = email;
        this.password = password;
    }


    public String getName() {
        return this.name;
    }

    public String getEmail() {
        return this.email;
    }

    public String getPassword() {
        return this.password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public boolean equals(Object o) {

        if (this == o)
            return true;
        if (!(o instanceof User user))
            return false;
        return Objects.equals(this.name, user.name)
                && Objects.equals(this.email, user.email)
                && Objects.equals(this.password, user.password);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.name, this.email, this.password);
    }

    @Override
    public String toString() {
        return "User{" + " name='" + this.name + '\'' + ", email='" + this.email + '\'' + ", password='" + this.password + '\'' + '}';
    }
}

