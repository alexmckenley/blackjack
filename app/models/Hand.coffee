class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  stand: ->
    console.log('Stand Event', @scores());
    @trigger('stand', @)

  lose: ->
    @trigger('lose')

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21 then @lose()
    if hasAce then [score, score + 10] else [score]

  getBestScore: ->
    scores = @scores()
    return scores[0] if scores.length is 1
    return scores[1] if scores[1] <= 21
    return scores[0]