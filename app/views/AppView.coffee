class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="deal-button">Deal</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": -> @model.get('playerHand').stand()
    "click .deal-button": ->
      console.log("Deal button: ", @)
      @model.setNewHands()
      @status()
      @render()

  initialize: ->
    @model.on('rebind', =>
      console.log("rebind event: ", @)
      @attachListeners()
    )
    @attachListeners()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  attachListeners: ->
    @model.get('playerHand').on('stand', => @model.dealersTurn())
    @model.get('playerHand').on('lose', => @status('lose'))
    @model.get('dealerHand').on('lose', => @status('win'))
    @model.get('dealerHand').on('push', => @status('push'))

  status: (status) ->
    switch status
      when 'win' then @$el.parent().addClass('winner')
      when 'lose' then @$el.parent().addClass('loser')
      when 'push' then @$el.parent().addClass('push')
      else @$el.parent().removeClass('loser winner')

