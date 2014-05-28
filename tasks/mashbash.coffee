# mashbash
# http://kellybecker.me
#
# Copyright (c) 2014 Kelly Becker
# Licensed under the MIT license.
'use strict'

module.exports = (grunt) ->
  Tusk = require('grunt-tusks').init grunt, ->
    @MashBash = require('../lib/mashbash')

  grunt.registerMultiTask 'mashbash', 'Mash Bash together until it works', ->
    options = this.options
      # Project
      buildDir: 'dist'
      # Generic
      pretty: true
      debug: false

    # Read the source files with Grunt
    options.gruntReadSourceFiles = true

    # Create a new Task Helper
    tusk = new Tusk(@, options)

    # Start processing files
    tusk.forFiles 'mash', (file, dest) ->
      @MashBash.parseData(file.data, options)
