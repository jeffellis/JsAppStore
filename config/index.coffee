config = require './default'

load = (filename) ->
    try
        configFile = require filename
        for key, val of configFile
            if typeof val is 'object' and config[key]? then _.extend config[key], val
            else config[key] = val
    catch ex
        log ex unless ex.code is 'MODULE_NOT_FOUND'

load './user'

module.exports = config