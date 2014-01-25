class window.CardView extends Backbone.View

  tagName: 'img'

  className: 'card'


  # template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    # @$el.children().detach().end().html
    if @model.get('revealed')
      rank = @model.get('rankName').toString().toLowerCase()
      suit = @model.get('suitName').toLowerCase()
      @$el.attr({'src': "images/cards/#{rank}-#{suit}.png"})
    else
      @$el.attr({'src': "images/card-back.png"})
    # @$el.html image
    # @$el.html @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
