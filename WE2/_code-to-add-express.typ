== Express Code
// Express Demo Cookie
```tsx
import express from 'express';
import cookieParser from 'cookie-parser';

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
