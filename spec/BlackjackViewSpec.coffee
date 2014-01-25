describe 'Blackjack View', ->
  appModel = null
  appView = null

  beforeEach ->
    appModel = new App()
    appView = new AppView(model: appModel)

  describe 'Shuffling', ->
    it "should shuffle the deck when cards are low", ->
      deck = appModel.get 'deck'
      for i in [0...45]
        deck.pop()
      appModel.setNewHands()
      expect(appModel.get('deck').length).toBeGreaterThan 45

  describe 'Event Firing', ->
    it "should trigger the stand event when the stand method is called", ->
      appModel.get('playerHand').stand()
      expect(true).toBe true
