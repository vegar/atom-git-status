GitStatusView = require './git-status-view'
{CompositeDisposable} = require 'atom'

module.exports = GitStatus =
  gitStatusView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @gitStatusView = new GitStatusView(state.gitStatusViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @gitStatusView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'git-status:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @gitStatusView.destroy()

  serialize: ->
    gitStatusViewState: @gitStatusView.serialize()

  toggle: ->
    console.log 'GitStatus was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
