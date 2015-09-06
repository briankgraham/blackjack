class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName %>.png"/>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    if @$el.hasClass('covered') 
    	@$el.children().attr('src', 'img/card-back.png')

