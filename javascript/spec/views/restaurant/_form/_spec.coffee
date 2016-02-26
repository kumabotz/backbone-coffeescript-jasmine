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
    beforeEach ->
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

    it 'should parse form data', ->
      expect(@restaurantForm.parseFormData(@serializedData)).toEqual(
        name: 'Panjab'
        rating: '5'
        postcode: '123456'
      )

    it 'should add a restaurant when form data is valid', ->
      spyOn(@restaurantForm, 'parseFormData').andReturn(
        name: 'Panjab'
        rating: '5'
        postcode: '123456'
      )
      @restaurantForm.save() # we mock the click by calling the method
      expect(@restaurantForm.collection.length).toEqual(1)

    it 'should not add a restaurant when form data is invalid', ->
      spyOn(@restaurantForm, 'parseFormData').andReturn(
        name: ''
        rating: '5'
        postcode: '123456'
      )
      @restaurantForm.save()
      expect(@restaurantForm.collection.length).toEqual(0)

    it 'should show validation errors when data is invalid', ->
      spyOn(@restaurantForm, 'parseFormData').andReturn(
        name: ''
        rating: '5'
        postcode: '123456'
      )
      @restaurantForm.save()
      expect($('.error', $(@invisibleForm)).length).toEqual(1)
