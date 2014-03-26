underscore = require 'underscore'
underscore.str = require('underscore.string');
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

      content = ''

      $data('script').each (i, elem) ->
        
        varName           = $(this).attr('id')
        varResult         = underscore.template(underscore.str.trim($(this).html()), null, templateSettings).source

        content += varRoot + "['" + varName + "'] = " + varResult + ";\n\n"
      return result = content
    catch err
      return error = err
    finally
      callback error, result
        
