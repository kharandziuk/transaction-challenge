request = require('supertest')
async = require 'async'
app = require '../app'

describe('API', ->
  it('integration test', (done)->
    async.series([
        (cb)->
          # PUT /transactionservice/transaction/10
          # { "amount": 5000, "type": "cars" }
          # => { "status": "ok" }
          request(app)
            .put('/transactionservice/transaction/11')
            .send({ amount: 5000, type: "cars" })
            .expect(200, { status: 'ok'})
            .end(cb)
        (cb)->
            # PUT /transactionservice/transaction/11
            # { "amount": 10000, "type": "shopping", "parent_id": 10 }
            # => { "status": "ok" }
            request(app)
              .put('/transactionservice/transaction/10')
              .send({ amount: 10000, type: "shopping", parent_id: 10 })
              .expect(200, { status: 'ok'})
              .end(cb)
        (cb)->
          # GET /transactionservice/types/cars
          # => [ 10 ]
          request(app)
            .get('/transactionservice/transaction/10')
            .expect(200, [10])
            .end(cb)
        (cb)->
          # GET /transactionservice/sum/10
          # => { "sum": 15000 }
          request(app)
            .get('/transactionservice/sum/10')
            .expect(200, {sum: 15000})
            .end(cb)
        (cb)->
          # GET /transactionservice/sum/11
          # => { "sum": 10000 }
          request(app)
            .get('/transactionservice/sum/10')
            .expect(200, {sum: 10000})
            .end(cb)
    ]
    done
    )

  )
)
