import dotenv from 'dotenv-flow';
// config() will read your .env file, parse the contents, assign it to process.env.
dotenv.config({path: 'src/config/'});

export default {
    port: process.env.PORT,
    key: process.env.API_KEY
}
