class Gourmet.Views.RestaurantForm extends Backbone.View
  events:
    'click #save': 'save'

  save: ->
    data = @parseFormData(@$el.serializeArray())
    newRestaurant = new Gourmet.Models.Restaurant(data)
    errors = newRestaurant.validate(newRestaurant.attributes)
    if errors then @handleErrors(errors) else @collection.create(newRestaurant)

  parseFormData: (serializeArray) ->
    _.reduce(serializeArray, @parseFormField, {})

  parseFormField: (collector, fieldObj) ->
    name = fieldObj.name.match(/\[(\w+)\]/)[1]
    collector[name] = fieldObj.value
    collector

  handleErrors: (errors) ->
    $('.control-group').removeClass('error')
    for key in (_.keys(errors))
      do (key) ->
        $input = $("#restaurant_#{key}")
        $input.closest('.control-group').addClass('error')
