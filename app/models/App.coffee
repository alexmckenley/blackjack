#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  dealersTurn: ->
    dealerHand = @get('dealerHand')
    playerHand = @get('playerHand')
    dealerHand.first().flip()
    while (Math.min.apply(@, dealerHand.scores()) < 17)
      dealerHand.hit()
    if playerHand.getBestScore() is dealerHand.getBestScore() then @trigger('push') 
    else if dealerHand.getBestScore() > playerHand.getBestScore() then playerHand.lose()
    else dealerHand.lose()

  setNewHands: ->
    if @lowDeck()
      console.log("The deck is low!  Reshuffled!")
      @set('deck', new Deck())
    console.log(@get('deck').length)
    # @set('deck', new Deck()) if @lowDeck()
    @set('playerHand', @get('deck').dealPlayer())
    @set('dealerHand', @get('deck').dealDealer())
    @trigger('rebind', @)

  lowDeck: ->
    if @get('deck').length > 8 then false else true
