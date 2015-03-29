{ScrollView} = require 'atom-space-pen-views'

module.exports = class GitStatusView extends ScrollView

   @URI: 'atom://git-status'

   @content: ->
     @div class: 'pane-item', =>
       @h1 "Git Status"

    getTitle: -> 'Git Status'
  #  getUri: -> @URI

    isEqual: (other) ->
      other instanceof GitStatusView
