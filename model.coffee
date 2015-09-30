assert = require 'assert'

class AccountModel
  constructor: ->
    @types = {}
    @amounts = {}
    @parentToChildren = {}
    @childToParent= {}
    @ofType= {}

  add: (id, amount, type, parentId)->
    assert not(id of @amounts), 'there is already a transaction with such id'
    @amounts[id] = amount
    @ofType[id] = type

    lstOfType = @types[type] or []
    lstOfType.push(id)
    @types[type] = lstOfType

    if parentId?
      @childToParent[id] = parentId
      lstOfChilren = @parentToChildren[parentId] or []
      lstOfChilren.push(id)
      @parentToChildren[parentId] = lstOfChilren


  get: (id)->
    return [
      @amounts[id], @ofType[id], @childToParent[id]
    ]

  getListByType: (type)-> @types[type]

  sum: (id)-> 
    lst = @parentToChildren[id] or []
    reduce = lst.reduce(
      (acc, next)=> acc + @sum(next),
      @amounts[id]
    )

module.exports = AccountModel
