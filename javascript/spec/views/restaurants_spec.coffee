describe "Restaurants view", ->
  restaurants_data = [
    {
      id: 0
      name: 'Ritz'
      postcode: 'N112TP'
      rating: 5
    }
    {
      id: 1
      name: 'Astoria'
      postcode: 'EC1E4R'
      rating: 3
    }
    {
      id: 2
      name: 'Waldorf'
      postcode: 'WE43F2'
      rating: 4
    }
  ]

  invisible_table = document.createElement('table')

  beforeEach ->
    @restaurants_collection = new Gourmet.Collections.RestaurantsCollection(restaurants_data)
    @restaurants_view = new Gourmet.Views.RestaurantsView(
      collection: @restaurants_collection
      el: invisible_table
    )

  it "should be defined", ->
    expect(Gourmet.Views.RestaurantsView).toBeDefined()

  it "should have the right element", ->
    expect(@restaurants_view.el).toEqual(invisible_table)

  it "should have the right collection", ->
    expect(@restaurants_view.collection).toEqual(@restaurants_collection)

  it "should render the view when initialized", ->
    expect($(invisible_table).children().length).toEqual(3)
