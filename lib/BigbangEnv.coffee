global.logPrefix = ""

# log may be used by some of the global requires (like config)
global.log      = (args...) ->
    console.log "#{new Date().toLocaleString()} #{Date.now()} #{logPrefix}", args...

require 'colors'
cluster       = require 'cluster'
global._      = require 'lodash'
# Adding an empty function to underscore.
_.mixin
    noop : () ->
global.CONFIG = require '../config'

global.logError = (args...) ->
    msg = "#{new Date().toLocaleString()} [ERROR] #{logPrefix}"
    for i,arg of args
        if arg?.stack
            stack = true
            args[i] = arg.stack
    console.log msg.red, args...
    unless stack or cluster.isMaster then console.trace()

global.debug    = (type, args...) ->
    if CONFIG.debug? and ((CONFIG.debug is true) or (typeof CONFIG.debug is 'string' and CONFIG.debug is type) or (typeof CONFIG.debug is 'object' and _.contains CONFIG.debug, type))
        console.log "#{new Date().toLocaleString()} #{Date.now()} #{logPrefix} [#{type}]".cyan, args...

global.notify = (title, msg, error = false) ->
    if error and msg is 'The "sys" module is now called "util". It should have a similar interface.'
        return

    try
    # proc.spawn 'growlnotify', ["-m", msg, title]
    catch e

    if error
        logError "#{title} : #{msg}"
    else
        console.log "#{title} : #{msg}".green

# Adding an empty function to underscore.
global._.mixin
    noop : () ->