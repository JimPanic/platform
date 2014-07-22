# Gruntfile.coffee
module.exports = taskManager = (grunt) ->
  # Initialize
  grunt.initConfig
    config:
      package: grunt.file.readJSON 'package.json'

    # contrib-clean config
    # (https://github.com/gruntjs/grunt-contrib-clean/blob/master/README.md)
    clean: [
      # Ignored files.
      'lib/**'
      'vendor/**'
      'components/**'

      # Previous builds.
      'build/**'
    ]

    # contrib-coffee config
    # (https://github.com/gruntjs/grunt-contrib-coffee/blob/master/README.md)
    coffee:
      compile:
        options:
          bare: true

        # Dynamically select files. (http://gruntjs.com/configuring-tasks#building-the-files-object-dynamically)
        expand: true
        cwd:  'src'

        src:  ['*.coffee']
        dest: 'lib/'
        ext:  '.js'

    # browserify config
    # (https://github.com/jmreidy/grunt-browserify/blob/master/README.md)
    browserify:
      all:
        src:  ['lib/package.js']
        dest: 'build/<%= config.package.name %>-<%= config.package.version %>.js'

    # contrib-uglify config
    # (https://github.com/gruntjs/grunt-contrib-uglify/blob/master/README.md)
    uglify:
      options:
        banner: '/*! <%= config.package.name %>-<%= config.package.version %>
         Built: <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      all:
        src:  'build/<%= config.package.name %>-<%= config.package.version %>.js'
        dest: 'build/<%= config.package.name %>-<%= config.package.version %>.min.js'

    # contrib-copy config
    # (https://github.com/gruntjs/grunt-contrib-copy/blob/master/README.md)
    copy:
      builds:
        files: [
          {
            src:  'build/<%= config.package.name %>-<%= config.package.version %>.js'
            dest: '<%= config.package.name %>.js'
          }, {
            src:  'build/<%= config.package.name %>-<%= config.package.version %>.min.js'
            dest: '<%= config.package.name %>.min.js'
          }
        ]

    # contrib-watch config
    # (https://github.com/gruntjs/grunt-contrib-watch/blob/master/README.md)
    watch:
      files: 'src/*.coffee'
      tasks: ['do']

  # Load npm tasks.
  modules = getKeys (grunt.config 'config.package').devDependencies
  plugins = ( module for module in modules when !!~module.indexOf 'grunt-' )

  grunt.loadNpmTasks plugin for plugin in plugins

  # Register custom tasks.
  grunt.registerTask 'compile', ['coffee']
  grunt.registerTask 'build',   ['browserify', 'uglify', 'copy']

  grunt.registerTask 'do',      ['compile', 'build']

  grunt.registerTask 'default', ['watch']

# Utils
getKeys = (obj) -> key for own key, value of obj
