class Gourmet.Views.RestaurantsView extends Backbone.View
  template: Hogan.compile($('#restaurant-template').html())

  initialize: ->
    @render(@collection)

  render: =>
    @$el.empty()
    for restaurant in @collection.models
      do (restaurant) =>
        @$el.append(@template.render(restaurant.toJSON()))
