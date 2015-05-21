Logs = new Mongo.Collection("logs")

Meteor.methods {
  log: (req) -> Logs.insert req.params
  resetLogs: -> Logs.remove({})
}

if Meteor.isClient

  Template.reset.events {
    'click button': -> Meteor.call 'resetLogs'
  }

  Template.log_viewer.helpers {
    logs: Logs.find({}, {transform: (log) ->
      log.message = ansi_up.ansi_to_html log.message
      log.class = switch log.level
        when 'silly' then 'active'
        when 'info' then 'info'
        when 'warn' then 'warning'
        when 'error' then 'danger'
      log.timestamp = Date.create(log.date).format("{hh}:{mm}:{ss}.{ms}")
      log
    })
  }
  Logs.find({}, {sort: timestamp:-1, limit: 1}).observeChanges {
    added: (id) ->
      setTimeout (->
        $(window).scrollTop $(document).height()
        $("##{id}").effect 'highlight'
      ), 200
  }


if Meteor.isServer
  Meteor.startup(->
    # code to run on server at startup
  )


