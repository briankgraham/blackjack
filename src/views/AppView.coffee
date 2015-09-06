class window.AppView extends Backbone.View
  template: _.template '
    <button class="btn btn-default hit-button">Hit</button> 
    <button class="btn btn-default stand-button">Stand</button>
    <button class="btn btn-success new-game">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': 'hitter'
    'click .stand-button': -> @model.get('playerHand').stand()
    'click .new-game': 'newGame'

  initialize: ->
    @model.get('playerHand').on 'stand', => 
                            @model.get('dealerHand').models[0].flip()
                            $('.hit-button').prop('disabled', true)
                            $('.stand-button').prop('disabled', true)
                            @dealerShit()
    @render()
    @blackjack()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$el.append(@input)
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  blackjack: ->
    if @model.get('playerHand').scores()[1] is 21
      $('.messages').append('woaaa brohaw. you just got space cat blackjack... .com')
      $('.hit-button').prop('disabled', true)
      $('.stand-button').prop('disabled', true)

  hitter: -> 
    dealer = @model.get('dealerHand')
    player = @model.get('playerHand')

    player.hit()

    if player.scores()[1] <= 21
      score = player.scores()[1]
    else 
      score = player.scores()[0]
    if score > 21
      player.bust()
      $('.hit-button').prop('disabled', true)
      $('.stand-button').prop('disabled', true)

    if score is 21
      $('.hit-button').prop('disabled', true)
      $('.stand-button').prop('disabled', true)
      dealer.models[0].flip()
      @dealerShit()

  dealerShit: ->
    dealer = @model.get('dealerHand')
    player = @model.get('playerHand')
    messages = $('.messages')
 
    dealerScore = @updateDealerScore()

    if dealerScore is 21
      messages.append("Dillur has wunn.")
      return

    while dealerScore < 17
      dealer.hit()
      dealerScore = @updateDealerScore()

    if dealerScore > 21
      messages.append("The diller bust\'d rurl hard. like rurly")

    else if dealerScore > player.scores()[1]
      messages.append("The dilller has wonne. hes being a smug asshole about it.")

    else if dealerScore is player.scores()[1]
      messages.append("PUSH IT. PUSH IT RURL GOOD.")

    else
      messages.append("Congratulations! You\'ve won! Someone should get you a beer bro.")

  updateDealerScore: ->
    dealer = @model.get('dealerHand')
    if dealer.scores()[1] <= 21
      dealer.scores()[1]
    else 
      dealer.scores()[0]

  newGame: ->
    $('.messages').empty();
    @$el.children().detach()
    new AppView(model: new App()).$el.appendTo '.container'

  updatePlayerScore: ->
    player = @model.get('playerHand')
    if player.scores()[1] <= 21
      player.scores()[1]
    else 
      player.scores()[0]


