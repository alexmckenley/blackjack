class window.AppView extends Backbone.View

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <button class="deal-button">Deal</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": ->
      @buttons(off)
      @model.get('playerHand').stand()
    "click .deal-button": ->
      @buttons(on)
      @model.setNewHands()
      @status()
      @render()

  initialize: ->
    @model.on('rebind', => @attachListeners())
    @model.on('unbind', => @detachListeners())
    @attachListeners()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  attachListeners: ->
    @model.get('playerHand').on('stand', => @model.dealersTurn())
    @model.get('playerHand').on('lose', => 
      @buttons(off)
      @status('lose'))
    @model.get('dealerHand').on('lose', => 
      @status('win'))
    @model.on('push', => @status('push'))

  detachListeners: ->
    @model.get('playerHand').off()
    @model.get('dealerHand').off()

  status: (status) ->
    switch status
      when 'win' then @$el.parent().addClass('winner')
      when 'lose' then @$el.parent().addClass('loser')
      when 'push' then @$el.parent().addClass('push')
      else @$el.parent().removeClass('loser winner push')

  buttons: (state)->
      @$('.hit-button').prop('disabled', !state)
      @$('.stand-button').prop('disabled', !state)
