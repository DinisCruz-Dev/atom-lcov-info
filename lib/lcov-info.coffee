LcovInfoView = require './lcov-info-view'

module.exports =
  config:
    highlightType:
      title: 'Highlight Type'
      description: 'Perform highlighting either on the line, or the gutter'
      type: 'string'
      default: 'gutter'
      enum: ['line', 'gutter']
    coveredType:
      title: 'Coverage Display'
      description: 'Display applies to everything or uncovered lines only'
      type: 'string'
      default: 'Covered & Uncovered Lines'
      enum: ['Covered & Uncovered Lines', 'Uncovered Lines Only']

  lcovInfoView: null

  activate: (state) ->
    @lcovInfoView = new LcovInfoView(state.lcovInfoViewState)

  deactivate: ->
    @lcovInfoView.destroy()

  serialize: ->
    lcovInfoViewState: @lcovInfoView.serialize()




set_File_Watcher = ()->
  fs = require 'fs'
  project_Folder = atom.project.path
  coverage_file = project_Folder + '/.coverage/lcov.info'

  console.log '>>>>> Watching file: ' + coverage_file
  watcher_Cov = fs.watchFile coverage_file, ()->
    console.log ">>>>> lcov file was changed, reloading data"
    atom.workspaceView.trigger('lcov-info:toggle')
  "done"

set_File_Watcher()
