ENTER = 13
class window.InputView extends Backbone.View
  tagName: 'input'
  className: 'form-control'
  events: 
    'keypress': 'changeName'

  initialize: -> 
  	@render()

  render: -> 
    $('.whatever').append(@$el)

  changeName:(e) ->
  	#console.log(e)
  	if e.which is ENTER
  		$('.name').text(e.target.value)
  		@$el.val('')
  		$('.whatever').empty()


  