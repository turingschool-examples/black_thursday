require_relative 'spec_helper'
require 'CSV'

RSpec.describe ItemRepository do
  describe 'instantiation' do
    it 'exists' do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)

      expect(item_repo).to be_a(ItemRepository)
    end

    it "returns array of all items and has readable attributes" do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)
      all = item_repo.all
      expect(all.length).to eq(4)
      expect(all.first.id).to eq(263395617)
      expect(all.first.name).to eq("Glitter scrabble frames")
      expect(all.first.description).to be_a(String)
      expect(all.first.unit_price).to eq(1300)
      expect(all.first.created_at).to be_a(String)
      expect(all.first.updated_at).to be_a(String)
      expect(all.first.merchant_id).to eq(12334185)
    end
  end

  describe 'methods' do
    it 'finds items with matching id' do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)
      id = 263395721
      expected = item_repo.find_by_id(id)

      expect(expected.id).to eq(id)
      expect(expected.name).to eq("Disney scrabble frames")

      id = 1
      expected = item_repo.find_by_id(id)

      expect(expected).to eq(nil)
    end

    it 'finds items by name' do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)
      name = "Vogue Paris Original Givenchy 2307"
      expected = item_repo.find_by_name("voguE Paris Original Givenchy 2307")

      expect(expected.name).to eq(name)
      expect(expected.id).to eq(263396209)


      name = "Sales Engine"
      expected = item_repo.find_by_name(name)

      expect(expected).to eq(nil)
    end

    it 'finds all items matching given description' do
      path = "fixture/item_fixture.csv"
      item_repo = ItemRepository.new(path)
      description = "Vogue Paris Original 2307; ca. 1980; Givenchy - Dress, fitted through the bustline with back-lapped bodice and straight front-wrapped lined skirt, four inches below mid-knee or evening length, has bodice pleated at right shoulder (no shoulder seam) and bodice front and skirt front and back gathered into waistline seam. Left side of skirt has draped waistline extension. Skirt lining has side zipper closing and deep left side hemline slit. Skirt has shaped hemline.\n\nFeatured in Vogue Patterns May/June 1980\n\nSize 14\n\nRefer to image for size info\n\nEnvelope shows storage wear and crumpling, opened to one side."
      expected = item_repo.find_all_with_description("dRESS, fitted through the bustline with back-lapped bodice and straight front-wrapped lined skirt")

      expect(expected.description).to eq(description)
      expect(expected.id).to eq(263396209)

      description = "llama smiles"
      expected = item_repo.find_all_with_description(description)

      expect(expected).to eq([])
      expect(expected.length).to eq(0)
    end

    it 'finds all items with that has a matching price' do
    path = "fixture/item_fixture.csv"
    item_repo = ItemRepository.new(path)
    price = 2999
    expected = item_repo.find_all_by_price(price)

    expect(expected.unit_price).to eq(price)

    price = 10
    expected = item_repo.find_all_by_price(price)

    expect(expected).to eq([])
    expect(expected.length).to eq(0)
    end
  end
end
