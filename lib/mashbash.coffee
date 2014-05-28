# mashbash
# http://kellybecker.me
#
# Copyright (c) 2014 Kelly Becker
# Licensed under the MIT license.
'use strict'

# Node Lib.
Path = require('path')
Fs   = require('fs')

# String Repeat
String.prototype.repeat = (x, y) ->
  new Array((x * (y || 1)) + 1).join(@)

module.exports = class MashBash

  @parseFile: (file, options) ->
    if data = File.read(file)
      new @(data, options).parse()


  @parseData: (data, options) ->
    new @(data, options).parse()


  constructor: (@data, @options) ->
    @data = @data.split("\n")
    @_ = @constructor


  indent:  0
  tabSize: null

  plugins: {}
  output:  []


  parse: ->
    for index, line of @data

      # Match data from the line with Regex
      matchLine = /^(\s*)((#!|> |<=)(.*)|.*)$/.exec(line)

      # Line Parsing
      parsedLine =
        lineNumber: parseInt(index) + 1
        isCommand:  !! matchLine[3]
        lineData:   matchLine[2]

      # Determine tab size and indentation
      if ! @tabSize && matchLine[1].length > 0
        @tabSize ||= matchLine[1].length
        indent = 1 # First indent is indent of 1
      else indent = matchLine[1].length / @tabSize

      # Add tab size and indentation to the parsedLine
      parsedLine.tabSize = @tabSize
      parsedLine.indent  = indent

      # Commands to run
      if matchLine[4]
        matchCmnd = matchLine[4].replace(/^[\s]*(.*?!)[\s]*$/)
        matchCmnd = /^((.*?!) (.*)|.*)$/.exec(matchCmnd)

        # Command information
        parsedLine.isCommand  = !! matchLine[3]
        parsedLine.command    = matchCmnd[2] || matchCmnd[1]
        parsedLine.arguments  = matchCmnd[3] && matchCmnd[3].split(" ")
        parsedLine.invocation = matchLine[3]

      # If the indent changed then invoke a callback
      try
        if indent < @indent
          @invoke('line:indent:down', parsedLine)
        else if indent > @indent
          @invoke('line:indent:up', parsedLine)
      catch e
        console.error(e)
      finally
        @indent = indent

      # Run a command on the line if needed
      if parsedLine.isCommand
        try
          @invoke('line:command', parsedLine)
        catch e
          console.error(e)

      @cache.push(parsedLine.lineData)

    @output.join("\n")
