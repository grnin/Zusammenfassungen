= ExpressJS
// #include "/WE2/_code-express-demo-todo.typ"

== Cookies
#image("/assets/express-js-1.png")
Server: `set-cookie:name=value;Expires=Wed, 09 Jun 2029 10:18:14 GMT`
Client: `cookie:name=value; name2=value2`

Cookies für "ExpresJS Session": ```js app.use(session({ secret: ,'1234567', resave: false, saveUninitialized: true})); ```

```js
const app = express();
app.use(cookieParser("secret"));

app.get("/cookieDemo/{*splat}", function (req, res) {
    console.log(JSON.stringify(req.cookies));
    console.log(JSON.stringify(req.signedCookies));
    res.cookie("url", req.url);
    res.cookie("signedUrl", req.url, {signed: true});

    if (req.cookies.url) {
        res.end(`dein letzter besuch:
Cookie: ${req.cookies.url}
SignedCookie: ${req.signedCookies.signedUrl || "---"}`);
    } else {
        res.end("Dein erster besuch?!")
    }
});

app.listen(3000, function () {
    console.log('listening on http://localhost:3000');
});
```




== JSON Web Token (JWT) JSON-based open standard (RFC 7519).
/ HTTP-Header: `Authorization: Bearer <token>`
