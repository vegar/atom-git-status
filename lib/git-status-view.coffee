{ScrollView, SelectListView} = require 'atom-space-pen-views'


module.exports = class GitStatusView extends ScrollView

  @URI: 'atom://git-status'

  @content: ->
    console.log("render content")
    @div class: 'pane-item',  =>
      @h1 "Git Status"
      @div class: 'select-list', =>
        @ul class: 'list group', outlet: 'list', =>
      @div class: 'block', =>
        @div outlet: 'statusArea'


  initialize: ->
    super
    @getStatus()

  getTitle: -> 'Git Status'

  isEqual: (other) ->
    other instanceof GitStatusView

  getStatus: ->
    git = require("git-promise") ;
    util = require("git-promise/util") ;

    projectRoot = atom.project.getPath() ;

    view = this

    git('status --porcelain --branch', {cwd: projectRoot} , (stdout) ->
      return util.extractStatus stdout
    ).then((status) ->
      status.workingTree.modified.forEach (file) =>
        view.list.append("<li><span class='inline-block status-modified icon icon-diff-modified'></span>#{file}</li>")
      view.statusArea.append(JSON.stringify(status, null, '  '))
      return
    ).fail (err) ->
      console.log err
      return
