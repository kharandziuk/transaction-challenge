expect = require('chai').expect
Model = require '../model.coffee'

describe 'Model', ->
  model = null
  beforeEach ->
    model = new Model
  it 'can add a transactions and get information', ->
    model.add(1, 10, 'car')
    expect(
      model.get(1)
    ).to.deep.equal([10, 'car', undefined])


  it 'can add few transactions of a different type and them', ->
    model.add(1, 10, 'car')
    model.add(2, 15, 'shopping')
    model.add(3, 18, 'car')
    expect(
      model.getListByType('car')
    ).to.have.members([1, 3])

  it 'can add few transactions of a different type and calc sum', ->
    model.add(1, 10, 'car')
    model.add(2, 15, 'shopping', 1)
    model.add(3, 18, 'car')
    expect(
      model.sum(1)
    ).to.equal(25)
    expect(
      model.sum(2)
    ).to.equal(15)
    expect(
      model.sum(3)
    ).to.equal(18)

  it 'can add few transactions; parent of parent of parent ', ->
    model.add(1, 10, 'car')
    model.add(2, 15, 'shopping', 1)
    model.add(3, 18, 'car', 2)
    expect(
      model.sum(1)
    ).to.equal(43)
    expect(
      model.sum(2)
    ).to.equal(33)
