Game = require("GamerBot-Game")

class Destiny extends Game
  lfg: ->
    return true

  events: ->
    return {
      CoO:
        name: "Court of Oryx"
        maxplayers: 3
      CoE:
        name: "Challenge of Elders"
        maxplayers: 3
      KFHM:
        name: "King's Fall - Hard Mode"
        maxplayers: 6
    }

  name: ->
    return "Destiny"

  platforms: ->
    return ['PS4','XBONE']

Helper = require('hubot-test-helper')
helper = new Helper('../src/GamerBot-Games.coffee')

expect = require('chai').expect

Games = require('../src/Games.coffee')

describe 'GamerBot-Games', ->
  beforeEach ->
    @room = helper.createRoom()

  afterEach ->
    @room.destroy()

  it 'registers a new game', ->
    @room.robot.emit "gamerbot.games.register", ({ ident: "dtg", name: "Destiny", class: Destiny })
    @room.user.say('bob','.games').then =>
      expect(@room.messages).to.eql [
        [ "bob",".games" ]
        [ "hubot", "```Game List:\ndtg ... Destiny\n```" ]
      ]

  it 'fetches a game', ->
    @room.robot.emit "gamerbot.games.register", ({ ident: "dtg", name: "Destiny", builder: new Destiny @room.robot })
    games = new Games @room.robot
    destiny = games.fetch_game('dtg').builder
    expect(destiny.name()).to.eql('Destiny')
