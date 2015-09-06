class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Diller<% }else{ %><span class ="name">dude bro</span><% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @collection.on 'bust', -> $('.messages').append('You\'re a buster!');
   
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    if @hasAnAce() 
      @$('.score').text @collection.scores()[1]
    else 
      @$('.score').text @collection.scores()[0]
  
  hasAnAce: ->
    #console.log(@collection.hasAce())
    if @collection.scores()[1] <= 21
      true
    else false


    
