assert = require 'assert'
express = require 'express'

app = express()


transactionRouter = express.Router()

transactionRouter.get('/transaction/:id', (req, res) ->
  assert.fail()
)

transactionRouter.put('/transaction/:id', (req, res) ->
)

app.use('/transactionservice', transactionRouter)


module.exports = app
