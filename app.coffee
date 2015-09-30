assert = require 'assert'
express = require 'express'
bodyParser = require 'body-parser'
Model = require './model'
_ = require 'underscore'

app = express()
app.use(bodyParser.json())



transactionRouter = express.Router()
model = new Model()

transactionRouter.get('/sum/:id', (req, res) ->
  id = Number(req.params['id'])
  res.json(
    sum: model.sum(id)
  )
)
transactionRouter.get('/types/:type', (req, res) ->
  {type} = req.params
  res.json(
    model.getListByType(type)
  )
)
transactionRouter.get('/transaction/:id', (req, res) ->
  {id} = req.params
  [amount, type, parent_id] = model.get(id)
  res.json({amount, type, parent_id})
)

transactionRouter.put('/transaction/:id', (req, res) ->
  id = Number(req.params['id'])
  {amount, type, parent_id} = req.body
  # I don't provide any validation
  assert amount
  assert _.isNumber(amount)
  assert type?
  assert _.isNumber(parent_id) if parent_id?

  model.add(
    id
    amount
    type
    parent_id
  )
  res.json(status: 'ok')
)

app.use('/transactionservice', transactionRouter)


module.exports = app

if (require.main is module)
  PORT = 8000
  app.listen(PORT, ->
    console.log("work on port #{PORT}")
  )
