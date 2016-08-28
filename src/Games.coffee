# Description
#   Games class for managing registered game list
#
# Author:
#   Shawn Sorichetti <ssoriche@gmail.com>

class Games
  constructor: (@robot) ->
    @games = {}

  register_game: (game) =>
    games = @robot.brain.get "gamerbot.games" ? {}
    games[game.ident] = game
    @robot.brain.set "gamerbot.games", games

  get_games: =>
    @robot.brain.get "gamerbot.games" ? {}

module.exports = Games
