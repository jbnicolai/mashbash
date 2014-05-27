# mashbash
# http://kellybecker.me
#
# Copyright (c) 2014 Kelly Becker
# Licensed under the MIT license.
'use strict'

module.exports = (grunt) ->

  # Node Lib.
  Path = require('path')

  # Internal lib.
  Chalk = require('chalk')
  Merge = require('coffee-script').helpers.merge
  Extend = require('coffee-script').helpers.extend

  # Variables
  projectRoot = process.cwd()
  projectBase = Path.basename(projectRoot)

  # Include MashBash
  MashBash = require('../lib/mash')
    .setProjectRoot(projectRoot)
    .setProjectBase(projectBase)
    .setGrunt(grunt)

  # Include Grunt Task Helper
  GruntTaskHelper = require('../lib/grunt/task_helper')
    .setProjectRoot(projectRoot)
    .setProjectBase(projectBase)
    .setGrunt(grunt)

  # Include custom file utilities
  File = require('../lib/file')

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
    task = new GruntTaskHelper(@, options)

    # Start processing files
    task.forFiles 'mash', (file, dest) ->
      MashBash.parseData(file.data, options)
