#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  dealersTurn: ->
    console.log("It is dealer's turn")
    dealerHand = @get('dealerHand')
    playerHand = @get('playerHand')
    dealerHand.first().flip()
    while (Math.min.apply(@, dealerHand.scores()) < 17)
      dealerHand.hit()
      console.log()
    if playerHand.getBestScore() is dealerHand.getBestScore() then @trigger('push') 
    else if dealerHand.getBestScore() > playerHand.getBestScore() then playerHand.lose()
    else dealerHand.lose()
    # checks score decide hit or stand
    # if stand, display winner on screen
    # gameend

  setNewHands: ->
    @set('playerHand', @get('deck').dealPlayer())
    @set('dealerHand', @get('deck').dealDealer())
    console.log("setNewHands: ", @)
    @trigger('rebind', @)
