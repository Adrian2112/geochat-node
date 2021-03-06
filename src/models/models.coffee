mongoose = require('mongoose')
moment = require('moment')

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

messageSchema = new Schema({
    date: {type: Date, default: Date.now},
    author: {type: String, default: 'Anon'},
    text: String
    place_id: String
})

messageSchema.method 'dateString', ->
  return moment(this.date).format("LLLL")

module.exports = mongoose.model('Message', messageSchema)
