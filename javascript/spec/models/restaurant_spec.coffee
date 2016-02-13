describe 'Restaurant Model', ->
  it 'should exist', ->
    expect(Gourmet.Models.Restaurant).toBeDefined()

  describe 'Attributes', ->
    ritz = new Gourmet.Models.Restaurant

    it 'should have default attributes', ->
      expect(ritz.attributes.name).toBeDefined()
      expect(ritz.attributes.postcode).toBeDefined()
      expect(ritz.attributes.rating).toBeDefined()

  describe 'Validations', ->
    attrs = {}

    beforeEach ->
      attrs =
        name: 'Ritz'
        postcode: 'N112TP'
        rating: 5

    afterEach ->
      ritz = new Gourmet.Models.Restaurant attrs
      expect(ritz.isValid()).toBeFalsy()

    it 'should validate the presence of name', ->
      attrs['name'] = null

    it 'should validate the presence of postcode', ->
      attrs['postcode'] = null

    it 'should validate the presence of rating', ->
      attrs['rating'] = null

    it 'should validate the numericality of rating', ->
      attrs['rating'] = 'foo'

    it 'should not accept a rating < 1', ->
      attrs['rating'] = 0

    it 'should not accept a rating > 5', ->
      attrs['rating'] = 6
