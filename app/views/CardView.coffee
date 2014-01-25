class window.CardView extends Backbone.View

  tagName: 'img'

  className: 'card'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    if @model.get('revealed')
      rank = @model.get('rankName').toString().toLowerCase()
      suit = @model.get('suitName').toLowerCase()
      @$el.attr({'src': "images/cards/#{rank}-#{suit}.png"})
    else
      @$el.attr({'src': "images/card-back.png"})
    @$el.addClass 'covered' unless @model.get 'revealed'
