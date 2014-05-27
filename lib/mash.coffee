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

# String Repeat
String.prototype.repeat = (x, y) ->
  new Array((x * (y || 1)) + 1).join(@)

module.exports = class MashBash
  @setProjectRoot: (@projectRoot) -> @
  @setProjectBase: (@projectBase) -> @
  @setGrunt: (@grunt) -> @


  @parseFile: (file, options) ->
    if data = File.read(file)
      new @(data, options).parse()


  @parseData: (data, options) ->
    new @(data, options).parse()


  constructor: (@data, @options) ->
    @data = @data.split("\n")
    @_ = @constructor


  output: []


  parse: ->
    for index, line of @data

      # Match data from the line with Regex
      matchLine = /^(\s*)((#!|> |<=)(.*)|.*)$/.exec(line)

      # Line Parsing
      parsedLine =
        lineNumber: parseInt(index) + 1
        isCommand:  !! matchLine[3]
        lineData:   matchLine[2]
        tabSize:    matchLine[1].length

      # Commands to run
      if matchLine[4]
        matchCmnd = matchLine[4].replace(/^[\s]*(.*?!)[\s]*$/)
        matchCmnd = /^((.*?!) (.*)|.*)$/.exec(matchCmnd)

        # Command information
        parsedLine.isCommand  = !! matchLine[3]
        parsedLine.command    = matchCmnd[2] || matchCmnd[1]
        parsedLine.arguments  = matchCmnd[3] && matchCmnd[3].split(" ")
        parsedLine.invocation = matchLine[3]

        # Run commands if needed
        parsedLine.lineData = @invoke(parsedLine)

      @output.push(" ".repeat(parsedLine.tabSize).concat(parsedLine.lineData))



    @output.join("\n")
