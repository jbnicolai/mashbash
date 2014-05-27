# mashbash
# http://kellybecker.me
#
# Copyright (c) 2014 Kelly Becker
# Licensed under the MIT license.
'use strict'

# Node Lib.
Path = require('path')
Fs   = require('fs')

# Local Lib.
File = require('./file')

module.exports = class MashBash
  output: []


  @parseFile: (file, options) ->
    if fs.existsSync(file)
      new @(file, options).parse()


  constructor: (@data, @options) ->
    @_ = @constructor

    @stream = streamfs.createReadStream file,
      encoding: "UTF-8",
      autoClose: true,
      flags: 'r'


  parse: ->
    @stream.on 'data', (data) ->
      if match = /^\s*> (.*)$/.exec data
        console.log match
      else if match = /^\s*<(.*)$/.exec data
        console.log match
      else
        console.log data

    output.join("\n")
