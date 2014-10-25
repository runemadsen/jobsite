class rsm.JobsNewView

  constructor: ->
    @editor = CodeMirror.fromTextArea($(".codemirrorify")[0], {
      mode: "text/html"
    })