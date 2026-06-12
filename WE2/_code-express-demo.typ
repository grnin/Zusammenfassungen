
// Aus der expressjs-lecture-demo

#let hinweis(style: "italic", t) = {
    set text(style: style, size: 0.8em)
    show raw: set text(font: code-font, size: 1.05em)
    t
}


#let code-block(body) = {
    block(
        fill: rgb("#eaf2ff7d"),
        stroke: (paint: rgb("#0b033884"), thickness: 0.5pt),
        inset: 5pt,
        radius: 4pt,
        above: 0.5em,
        below: 1em,
        body,
    )
}

==== index.js
```js
import {app} from './app.js'

const hostname = '127.0.0.1';
const port = 3001;
app.listen(port, hostname, (error) => {
    if(error){
        console.error(error);
    }
    else {
        console.log(`Server running at http://${hostname}:${port}/`);
    }
});
```
==== app.js
```js
import express from 'express';
import path from 'path';
import session from 'express-session';
import exphbs from 'express-handlebars';
// (more imports inline for readability)

```


// #line()
```js
export const app = express();
const hbs = exphbs.create({
    extname: '.hbs',
    defaultLayout: "default",
    helpers: {
        ...helpers
} });
```

#code-block(
    [

        // === helpers/handlebar-util.js

        ```js
        // import { helpers } from './utils/handlebar-util.js'
        export const helpers = {
            'if_eq': function (a, b, opts) {
                if (a === b)
                    return opts.fn(this);
                else
                    return opts.inverse(this);
        }    }
        ```

    ],
);


```js
app.engine('hbs', hbs.engine);
app.set('view engine', 'hbs');
app.set('views', path.resolve('views'));
```

#code-block[
    ==== views/index.hbs
    ```js
    {{data}}
    ```
    ==== views/layouts/default.hbs
    ```html
    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
      <meta http-equiv="X-UA-Compatible" content="ie=edge">
      <title>Todo</title>
      {{#if_eq theme 'dark'}}
        <style>
          body {
            background: black;
            color: white;
          }
        </style>
      {{/if_eq}}
    </head>
    <body>
    {{{body}}}
    </body>
    </html>

    ```
]

```js
app.use(express.static(path.resolve('public')));
app.use(session({secret: 'casduichasidbnuwezrfinasdcvjkadfhsuilfuzihfioda', resave: false, saveUninitialized: true}));
app.use(sessionUserSettings);
```


```js
// import { sessionUserSettings } from './utils/session-middleware.index.js'
```
#code-block(
    [
        // ===== utils/session-middleware.index.js
        ```js
        export const sessionUserSettings = (req, res, next) => {
            const userSettings = req.session?.userSettings || {orderBy: 'title', orderDirection: -1, theme: 'dark'};
            const {orderBy, orderDirection, theme} = req.query;

            if (theme) {
                userSettings.theme = theme;
            }
            if (orderBy) {
                userSettings.orderBy = orderBy;
            }
            if (orderDirection) {
                userSettings.orderDirection = orderDirection;
            }
            req.userSettings = req.session.userSettings = userSettings;
            res.locals = req.userSettings; // visible within views

            next();
        };
        ```
    ],
);


```js
app.use(express.urlencoded({extended: false}));
app.use(express.json());

app.use("/", indexRoutes);
```

#code-block[
    // === routes/index-routes.js
    ```js
    // import { indexRoutes } from './routes/index-routes.js';
    import express from 'express';
    const router = express.Router();
    import {indexController} from '../controller/index-controller.js';
    ```
    #code-block[
        // === controller/index-controller.js
        ```js
        export class IndexController {
            index(req, res) {
                res.render("index", {data: "Hello World"});
            };
        } export const indexController = new IndexController();
        ```
    ]

    ```js
    router.get("/", indexController.index.bind(indexController));
    export const indexRoutes = router;
    ```
]


