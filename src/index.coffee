express = require 'express'
stylus = require 'stylus'
assets = require 'connect-assets'
socket = require('socket.io')
io = socket.listen(app, { log: false })

app = express()
# Add Connect Assets
app.use assets()
# Set View Engine
app.set 'view engine', 'jade'

require('./routes/routes.js')(app, io)

# Define Port
port = process.env.PORT or process.env.VMC_APP_PORT or 3000
# Start Server
app.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."
