mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

messageSchema = new Schema({
    date: {type: Date, default: Date.now},
    author: {type: String, default: 'Anon'},
    text: String
    place_id: String
})

module.exports = mongoose.model('Message', messageSchema)
