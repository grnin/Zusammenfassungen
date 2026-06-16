
#import "/WE2/helpers.typ": *



// ```
// #code-block[
//     ==== filename.type
//     ```ts

//     ```
// ]
// ```ts


= Express Testat Code
==== index.js
// import dotenv from 'dotenv';
```js
dotenv.config({ // load config-file
    path: `.env${process.env.NODE_ENV ? `-${process.env.NODE_ENV}` : ''}`,
});
const app = (await import('./app')).app;
const hostname = '127.0.0.1';
const port = 3001;
app.listen(port, hostname, (error: any) => {
    if (error) { console.log(error);
    } else { console.log(`Server running at http://${hostname}:${port}/`); }
});
```

==== app.js
```js
import express, { NextFunction, Request, Response } from 'express';
import path from 'path';
import cors from 'cors';

import { userRoutes } from './routes/user-routes';
import { accountRoutes } from './routes/account-routes';
import { transactionRoutes } from './routes/transaction-routes';
import { CONFIG } from './config';
import { expressjwt } from 'express-jwt';
import { HttpError } from './services/http-error';

export const app = express();

app.use(cors());
app.use(express.static(path.resolve('public')));
app.use(express.json());

app.use(
    expressjwt(CONFIG.jwt_validate).unless({
        path: [/\/login*/, /\/register/],
    }),
);
```
#code-block[
    ==== services/user-service.ts
    ```ts
    // Aufbau mit class UserService und private db wie anderer Service
    async register(data: UserRegister): Promise<LoginResult> {
        const uuid = randomUUID();
        const newUser: User = {
            uuid: uuid,
            name: data.name,
            email: data.email,
            pwdHash: CryptoUtil.hashPwd(data.password),
        };
        await this.db.insertAsync(newUser);
        accountService.create(uuid);
        const token = await CryptoUtil.createJWT({ uuid: uuid });
        const owner = {
            uuid: uuid,
            name: data.name,
            email: data.email,
        };
        return {
            owner: owner,
            token: token,
        };
    }
    ```
]
```ts

// app.use('/users', userRoutes);
// app.use('/accounts', accountRoutes);
app.use('/transactions', transactionRoutes);

// Error Middleware
app.use((err: Error, req: Request, res: Response, next: NextFunction) => {
    if (err instanceof HttpError) {
        return res.status(err.status).json({ message: err.message });
    }
    if (err.name === 'UnauthorizedError') {
        return res.status(401).json({ message: 'No token / Invalid token provided' });
    }
    return res.status(400).json({ message: 'something went wrong', err });
});
```

==== routes/transaction-routes.ts
```tsx
import express from 'express';
import { transactionController } from '../controller/transaction-controller';

const router = express.Router();

router.post('/', transactionController.create);
// router.get('/', transactionController.getTransactions);
// router.get('/:accountNr', transactionController.getTransactions);

export const transactionRoutes = router;
```

==== controller/transaction-controller.ts
// import { Request, Response } from 'express';
// import { HttpError } from '../services/http-error';
// import { AddTransactionSchema, FindTransactionSchema, transactionService } from '../services/transaction-service';
```ts
// imports hier.
export class TransactionController {
public create = async (req: Request, res: Response) => {
    const auth = req.headers.authorization;
    if (!auth) { throw new HttpError(401, 'no token provided'); }
    if (!req.auth?.uuid) { throw new HttpError(401, 'Unauthorized'); }

    // Schema nutzen, um die Body Daten zu validieren "schema.safeParse(data)"
    const data = SchemaUtil.parseOrThrow(AddTransactionSchema, req.body);
```
#code-block[
    ==== utils/schema-util.ts
    ```ts
    export class SchemaUtil {
        static parse<T>(schema: z.ZodType<T>, data: unknown): T | false{
            const result = schema.safeParse(data);
            if (!result.success) { return false; }
            return result.data;
        }
        static parseOrThrow<T>(schema: z.ZodType<T>, data: unknown): T {
            const result = schema.safeParse(data);
            if (!result.success) {
                throw new HttpError(400,  result.error, "schema_validation_error");
            }
            return result.data;
    }   }
    ```
]
```ts
    const userUuid = req.auth.uuid;

    // import { accountService } from '../services/account-service';
    const isOwner = await accountService.isOwner(data.from, userUuid);
```
(accountService code at end)
```ts
    if (!isOwner) { throw new HttpError(403, 'Incorrect user'); }
    await transactionService.create(data);
    return res.status(200).json({ success: true });
};
```

// ```
#code-block[
    ==== services/transaction-service.ts
    ```ts
    import Datastore from '@seald-io/nedb';
    import { z } from 'zod';
    import { accountService } from './account-service';
    import { HttpError } from './http-error';

    // Schema definieren für Input Validation:
    const TransactionSchema = z.object({
        from: z.number(), // can be float
        amount: z.number().int(),
        date: z.date(), to:.., total:..
    });
    // Typescript Typ davon ableiten:
    type Transaction = z.infer<typeof TransactionSchema>;

    export const AddTransactionSchema = z.object({
      amount: z.number().int().positive(), from:.., to:..,
    }); type AddTransaction = z.infer<typeof AddTransactionSchema>;

    type FindTransactionResult = {
        docs: Transaction[]; count: number; skip: number; docCount: number;
    };

    export const FindTransactionSchema = z.object({
        accountNr: z.coerce.number(),
        count: z.coerce.number().int().positive().optional().default(10),
        skip: z.coerce.number().int().nonnegative().optional().default(0),
    }); type FindTransaction = z.infer<typeof FindTransactionSchema>;

    export class TransactionService {
        private db: Datastore<Transaction>;

        constructor() { this.db = new Datastore({}); }

        async create(data: AddTransaction): Promise<void> {
            const from = await accountService.get(data.from);
            if (from.balance < data.amount) {
                throw new HttpError(400, 'Insufficient funds');
            }
          //  throw error if amount < 0, sending to yourself..

            const newFromBalance = from.balance - data.amount;
            const to = await accountService.get(data.to);
            const newToBalance = to.balance + data.amount;

            const date = new Date();
            await this.db.insertAsync({ from: data.from,... });
    ```

    //   await this.db.insertAsync({
    //       from: data.from,
    //       to: data.to,
    //       amount: data.amount,
    //       date: date,
    //       total: newFromBalance,
    //   });

    ```ts
            await accountService.update(from.accountNr, { balance: newFromBalance });
            await accountService.update(to.accountNr, { balance: newToBalance });
        } // transactionService.create

        async find(data: FindTransaction): Promise<FindTransactionResult> {
            const {accountNr, count, skip} = data; // destructured
            const filter = {
                $or: [{ from: accountNr, amount: {$lte: 0} }, { to: accountNr, amount: {$gte: 0} }],
            }; // statt: docs=sortedDocs.slice(skip, skip + count)

            let transactions = await this.db.findAsync(filter)
                .sort({ date: -1 })
                .skip(skip)
                .limit(count);

            const docCount = await this.db.countAsync(filter);
            // optional mit Promise.all() statt db.countAsync danach
            // const [docCount, docs] = await Promise.all([this.db.countAsync(filter), transactions.execAsync()])

            return {
                docs: transactions,
                count,
                skip,
                docCount,
            };
        } // transactionService.find
    } export const transactionService = new TransactionService();
    ```
]
// ```ts

// #code-block[
==== services/account-service.ts
```ts
// imports and define schemas like transaction-service.ts
export class AccountService {
    // private db with constructor like transaction-service
    // here is the file version:
    constructor() {
        this.db = new Datastore({ filename: './data/account.db', autoload: true });
        // index und stellt Einzigartigkeit sicher:
        this.db.ensureIndexAsync({ fieldName: 'owner', unique: true });
        this.db.ensureIndexAsync({ fieldName: 'accountNr', unique: true });
    }

    // const isOwner = await accountService.isOwner(data.from, userUuid);
    async isOwner(accountNr: number, userId: string) {
        const account = await this.get(accountNr);
        return account.owner === userId;
    }

    // const to = await accountService.get(data.to);
    async get(accountNr: number) {
        const account = await this.db.findOneAsync({ accountNr });
        if (!account) { throw new HttpError(404, `${accountNr} not Found`); }
        return account;
    }

    // await accountService.update(to.accountNr, { balance: newToBalance });
    async update(accountNr: number, data: Update) {
        const account = await this.db.updateAsync(
            { accountNr }, { $set: data }, { multi: false, returnUpdatedDocs: true },
        );
        if (!account.affectedDocuments) { throw new HttpError(404, `${accountNr} not Found`); }
        return true;
    }
```
// ]



=== Zusatz von letzter Vorlesung

Weshalb ist die letzte Zeile mit dem cast hier nötig?
```ts
const raw = await this.db.find(query).sort({ date: -1 })
    .skip(validatedData.skip).limit(validatedData.count)
    .execAsync();
const docs = (Array.isArray(raw) ? raw : [raw]) as Transaction[];
```
> sicherstellen, dass es als Array gesehen wird, nicht einfach any sondern [].. nedb Typ `Cursor<T[]>` nicht wie von `Cursor<T>`.  // TODO, bin mir nicht gaaanz sicher.
// https://github.com/seald/nedb/issues/71 uff
