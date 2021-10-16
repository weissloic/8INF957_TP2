"use strict";
exports.__esModule = true;
exports.Routes = void 0;
var user_controller_1 = require("../controller/user.controller");
var Routes = /** @class */ (function () {
    function Routes() {
    }
    Routes.prototype.routes = function (app) {
        /**
         *  @swagger
         * /customers:
         *  get:
         *    description: Use to request all users
         *    responses:
         *      '200':
         *        description: A successful response
         *      '500':
         *        description: internal server error
         *
         */
        app.route("/users").get(user_controller_1.UserController.getAll);
    };
    return Routes;
}());
exports.Routes = Routes;
//# sourceMappingURL=routes.js.map