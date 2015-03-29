{CompositeDisposable} = require 'atom'

GitStatusUri = 'atom://git-status'

createGitStatusView = (state) ->
  console.log 'GitStatus was toggled!'

  GitStatusView = require './git-status-view'
  new GitStatusView(state)

atom.deserializers.add
  name: 'GitStatusView'
  deserialize: (state) -> createGitStatusView(state)


module.exports = GitStatus =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.workspace.addOpener (filePath) ->
      createGitStatusView(uri: GitStatusUri) if filePath is GitStatusUri

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'git-status:toggle', ->
      atom.workspace.open(GitStatusUri)

  deactivate: ->
    @subscriptions.dispose()
