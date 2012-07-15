Message = require "../models/models.js"

module.exports = (app, io) ->

  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/places/:id/:name', (req, res) ->
    Message.find {place_id: req.params.id}, (error, messages)->
      res.render 'places/show', {messages: messages, name: req.params.name, place_id: req.params.id}

  io.sockets.on "connection", (client) ->

    client.on "post_message", (message) ->
      message = new Message(message)
      client.broadcast.emit("new_message", message)
      message.save()
