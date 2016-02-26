describe 'Restaurants view', ->
  restaurantsData = [
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

  invisibleTable = document.createElement('table')

  beforeEach ->
    @server = sinon.fakeServer.create()
    @restaurantsCollection = new Gourmet.Collections.RestaurantsCollection(restaurantsData)
    @restaurantsView = new Gourmet.Views.RestaurantsView(
      collection: @restaurantsCollection
      el: invisibleTable
    )

  afterEach ->
    @server.restore()

  it 'should be defined', ->
    expect(Gourmet.Views.RestaurantsView).toBeDefined()

  it 'should have the right element', ->
    expect(@restaurantsView.el).toEqual(invisibleTable)

  it 'should have the right collection', ->
    expect(@restaurantsView.collection).toEqual(@restaurantsCollection)

  it 'should remove the restaurant when clicking the remove icon', ->
    removeBtn = $('.remove', $(invisibleTable))[0]
    $(removeBtn).trigger('click')
    removeRestaurant = @restaurantsCollection.get(removeBtn.id)
    expect(@restaurantsCollection.length).toEqual(2)
    expect(@restaurantsCollection.models).not.toContain(removeRestaurant)

  it 'should render the view when initialized', ->
    expect($(invisibleTable).children().length).toEqual(3)

  it 'should render when an element is added to the collection', ->
    @restaurantsCollection.add(
      name: 'Panjab'
      rating: 5
      postcode: 'N2243T'
    )
    expect($(invisibleTable).children().length).toEqual(4)

  it 'should render when an element is removed from the collection', ->
    @restaurantsCollection.pop()
    expect($(invisibleTable).children().length).toEqual(2)

  it 'should remove a restaurant from the collection', ->
    evt = { target: { id: 1 } }
    @restaurantsView.removeRestaurant(evt)
    expect(@restaurantsCollection.length).toEqual(2)

  it 'should send an ajax request to delete the restaurant', ->
    evt = { target: { id: 1 } }
    @restaurantsView.removeRestaurant(evt)
    expect(@server.requests.length).toEqual(1)
    expect(@server.requests[0].method).toEqual('DELETE')
    expect(@server.requests[0].url).toEqual('/restaurants/1')
