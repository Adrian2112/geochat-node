express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
mongoose = require 'mongoose'
mongoose.connect('mongodb://localhost/geochat')


app = express()

http = require('http')
server = http.createServer(app)
io = require('socket.io').listen(server, {log: false})

io.configure ->
  io.set("transports", ["xhr-polling"])
  io.set("polling duration", 10)



# Add Connect Assets
app.use assets()
# Set View Engine
app.set 'view engine', 'jade'

# serve statics assets from public
app.use express.static(__dirname + "/../public")

require('./routes/routes.js')(app, io)

# Define Port
port = process.env.PORT or process.env.VMC_APP_PORT or 3000
# Start Server
server.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."
