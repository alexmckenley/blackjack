describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    expect(collection.length).toBe 52

  it "should be concealed when flipped", ->
    card = new Card
      rank: 30 % 13
      suit: Math.floor(30 / 13)
    card.flip()
    expect(card.get 'revealed').toBe(false)
