module.exports = (app, io) ->
  # Get root_path return index view
  app.get '/', (req, resp) ->
    resp.render 'index'

