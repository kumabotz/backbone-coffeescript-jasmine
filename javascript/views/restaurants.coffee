class Gourmet.Views.RestaurantsView extends Backbone.View
  template: Hogan.compile($('#restaurant-template').html())

  events:
    'click .remove': 'removeRestaurant'

  initialize: ->
    @render(@collection)
    @collection.on('add', @render)
    @collection.on('remove', @render)

  render: =>
    @$el.empty()
    for restaurant in @collection.models
      do (restaurant) =>
        @$el.append(@template.render(restaurant.toJSON()))

  removeRestaurant: (e) =>
    id = e.target.id
    model = @collection.get(id)
    @collection.remove(model)
    model.destroy()
