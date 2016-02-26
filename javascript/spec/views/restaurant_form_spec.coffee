describe 'Restaurant Form', ->
  jasmine.getFixtures().fixturesPath = 'javascript/spec/fixtures'

  beforeEach ->
    loadFixtures('restaurant_form.html')
    @invisibleForm = $('#restaurant-form')
    @restaurantForm = new Gourmet.Views.RestaurantForm(
      el: @invisibleForm
      collection: new Gourmet.Collections.RestaurantsCollection
    )

  it 'should be defined', ->
    expect(Gourmet.Views.RestaurantForm).toBeDefined()

  it 'should have the right element', ->
    expect(@restaurantForm.$el).toEqual(@invisibleForm)

  it 'should have a collection', ->
    expect(@restaurantForm.collection).toEqual(new Gourmet.Collections.RestaurantsCollection)

  describe 'form submit', ->
    # attrs need to be alphabetical ordered
    validAttrs =
      name: 'Panjab'
      postcode: '123456'
      rating: '5'

    invalidAttrs =
      name: ''
      postcode: '123456'
      rating: '5'

    beforeEach ->
      @server = sinon.fakeServer.create()
      @serializedData = [
        {
          name: 'restaurant[name]'
          value: 'Panjab'
        }
        {
          name: 'restaurant[rating]'
          value: '5'
        }
        {
          name: 'restaurant[postcode]'
          value: '123456'
        }
      ]
      spyOn(@restaurantForm.$el, 'serializeArray').andReturn(@serializedData)

    afterEach ->
      @server.restore()

    it 'should parse form data', ->
      expect(@restaurantForm.parseFormData(@serializedData)).toEqual(validAttrs)

    it 'should add a restaurant when form data is valid', ->
      spyOn(@restaurantForm, 'parseFormData').andReturn(validAttrs)
      @restaurantForm.save() # we mock the click by calling the method
      expect(@restaurantForm.collection.length).toEqual(1)

    it 'should not add a restaurant when form data is invalid', ->
      spyOn(@restaurantForm, 'parseFormData').andReturn(invalidAttrs)
      @restaurantForm.save()
      expect(@restaurantForm.collection.length).toEqual(0)

    it 'should send an ajax request to the server', ->
      spyOn(@restaurantForm, 'parseFormData').andReturn(validAttrs)
      @restaurantForm.save()
      expect(@server.requests.length).toEqual(1)
      expect(@server.requests[0].method).toEqual('POST')
      expect(@server.requests[0].requestBody).toEqual(JSON.stringify(validAttrs))

    it 'should show validation errors when data is invalid', ->
      spyOn(@restaurantForm, 'parseFormData').andReturn(invalidAttrs)
      @restaurantForm.save()
      expect($('.error', $(@invisibleForm)).length).toEqual(1)
