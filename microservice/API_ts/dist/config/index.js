"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
exports.__esModule = true;
var dotenv_flow_1 = __importDefault(require("dotenv-flow"));
// config() will read your .env file, parse the contents, assign it to process.env.
dotenv_flow_1["default"].config({ path: 'src/config/' });
exports["default"] = {
    port: process.env.PORT
};
//# sourceMappingURL=index.js.map