"use strict";
exports.__esModule = true;
exports.UserController = void 0;
var UserController = /** @class */ (function () {
    function UserController() {
    }
    UserController.getAll = function (req, res) {
        res.json([]).status(200);
        // UsereService.getAll().then((users: UserModel[]) => {
        //     res.json(users).status(200)
        // }).catch(() => {
        //     res.status(500);
        // })
    };
    return UserController;
}());
exports.UserController = UserController;
//# sourceMappingURL=user.controller.js.map