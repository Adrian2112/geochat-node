module.exports = (app, io) ->

  app.get '/', (req, resp) ->
    resp.render 'index'

