Simple transaction challenge:

```
PUT /transactionservice/transaction/10
{ "amount": 5000, "type": "cars" }
=> { "status": "ok" }
PUT /transactionservice/transaction/11
{ "amount": 10000, "type": "shopping", "parent_id": 10 }
=> { "status": "ok" }
GET /transactionservice/types/cars
=> [ 10 ]
GET /transactionservice/sum/10
=> { "sum": 15000 }
GET /transactionservice/sum/11
=> { "sum": 10000 }
```

## Run a project:
 - `npm install`
 - `npm start`

## Run tests:
 - `npm install`
 - `npm test`
