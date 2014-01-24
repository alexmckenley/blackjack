#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  dealersTurn: ->
    console.log("It is dealer's turn")
    # flip the card
    # check the score
    # decide hit or stand
    # if stand, display winner on screen
    # gameend

  setNewHands: ->
    @set('playerHand', @get('deck').dealPlayer())
    @set('dealerHand', @get('deck').dealDealer())
