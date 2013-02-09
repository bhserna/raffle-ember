window.App = Ember.Application.create()

App.IndexRoute = Ember.Route.extend
  setupController: ->
    @controllerFor('entries').set 'content', App.Entry.find()
    @controllerFor('new_entry').set 'content', name: ''

App.IndexController = Ember.ObjectController.extend
  drawWinner: ->
    entries = @controllerFor('entries').get('content')
    entries.setEach 'isLastWinner', false
    pool = entries.filterProperty 'winner', false

    if pool.length > 0
      entry = pool[Math.floor(Math.random()*pool.length)]
      entry.set 'winner', true
      entry.set 'isLastWinner', true
      @store.commit()

App.EntriesController = Ember.ArrayController.extend()

App.NewEntryController = Ember.ObjectController.extend
  add: ->
    App.Entry.createRecord name: @get 'name'
    @store.commit()
    @set 'content', name: ''

App.Store = DS.Store.extend
  revision: 11

DS.RESTAdapter.configure "plurals", entry: "entries"

App.Entry = DS.Model.extend
  name: DS.attr('string')
  winner: DS.attr('boolean')
