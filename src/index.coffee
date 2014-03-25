underscore = require 'underscore'
cherrio = require 'cheerio'
varPath = require 'path'

module.exports = class StaticUnderscoreCompliler
  brunchPlugin: yes
  type: 'template'
  extension: 'html'
  
  constructor: (@config) ->
    null
    
  compile: (data, path, callback) ->
    try
      varExt            = varPath.extname(path)
      output            = @config.plugins?.static_underscore?.output ? "source"
      varRoot           = @config.plugins?.static_underscore?.varRoot or "window"
      templateSettings  = @config.plugins?.underscore
      
      $data             = cherrio.load data
      varName           = $data('script').attr('id')
      varResult         = underscore.template($data.html(), null, templateSettings).source

      content = varRoot + "['" + varName + "'] = " + varResult + ";\n\n"
      return result = content
    catch err
      return error = err
    finally
      callback error, result
        
