require_relative 'spec_helper'

RSpec.describe ItemRepository do
  before :each do
    @mock_engine = double("ItemRepository")
    @path = "fixture/item_fixture.csv"
    @item_repo = ItemRepository.new(@path, @mock_engine)
  end

  describe 'instantiation' do
    it 'exists' do
      expect(@item_repo).to be_a(ItemRepository)
    end

    it "returns array of all items and has readable attributes" do
      all = @item_repo.all

      expect(all).to be_an(Array)
      expect(all.length).to eq(4)
      expect(all.first.id).to eq(263395617)
      expect(all.first.name).to eq("Glitter scrabble frames")
      expect(all.first.description).to be_a(String)
      expect(all.first.unit_price).to eq(0.13e2)
      expect(all.first.created_at).to be_a(Time)
      expect(all.first.updated_at).to be_a(Time)
      expect(all.first.merchant_id).to eq(12334185)
    end
  end

  describe 'methods' do
    it 'finds items with matching id' do
      id = 263395721
      expected = @item_repo.find_by_id(id)

      expect(expected).to be_an(Item)
      expect(expected.id).to eq(id)
      expect(expected.name).to eq("Disney scrabble frames")

      id = 1
      expected = @item_repo.find_by_id(id)

      expect(expected).to eq(nil)
    end

    it 'finds items by name' do
      name = "Vogue Paris Original Givenchy 2307"
      expected = @item_repo.find_by_name("voguE Paris Original Givenchy 2307")

      expect(expected).to be_an(Item)
      expect(expected.name).to eq(name)
      expect(expected.id).to eq(263396209)

      name = "Sales Engine"
      expected = @item_repo.find_by_name(name)

      expect(expected).to eq(nil)
    end

    it 'finds all items matching given description' do
      description = "Vogue Paris Original 2307; ca. 1980; Givenchy - Dress, fitted through the bustline with back-lapped bodice and straight front-wrapped lined skirt, four inches below mid-knee or evening length, has bodice pleated at right shoulder (no shoulder seam) and bodice front and skirt front and back gathered into waistline seam. Left side of skirt has draped waistline extension. Skirt lining has side zipper closing and deep left side hemline slit. Skirt has shaped hemline.\n\nFeatured in Vogue Patterns May/June 1980\n\nSize 14\n\nRefer to image for size info\n\nEnvelope shows storage wear and crumpling, opened to one side."
      expected = @item_repo.find_all_with_description("dRESS, fitted through the bustline with back-lapped bodice and straight front-wrapped lined skirt")

      expect(expected).to be_an(Array)
      expect(expected.first.description).to eq(description)
      expect(expected.first.id).to eq(263396209)

      description = "llama smiles"
      expected = @item_repo.find_all_with_description(description)

      expect(expected).to eq([])
      expect(expected.length).to eq(0)
    end

    it 'finds all items with that has a matching price' do
      price = 0.2999e2
      expected = @item_repo.find_all_by_price(price)

      expect(expected).to be_an(Array)
      expect(expected.first.unit_price).to eq(price)

      price = 10
      expected = @item_repo.find_all_by_price(price)

      expect(expected).to eq([])
      expect(expected.length).to eq(0)
    end

    it 'returns items where the price is in the supplied price range' do
      range = 0.13e2..0.135e2
      expected = @item_repo.find_all_by_price_in_range(range)

      expect(expected).to be_an(Array)
      expect(expected.length).to eq(2)
      expect(expected.first.id).to eq(263395617)

      range = 23.00e2..24.00e2
      expected = @item_repo.find_all_by_price_in_range(range)

      expect(expected).to eq([])
    end

    it 'can return item with supplied, matching merchant_id' do
      merchant_id = 12334185
      expected = @item_repo.find_all_by_merchant_id(merchant_id)

      expect(expected).to be_an(Array)
      expect(expected.length).to eq(3)
      expect(expected.last.id).to eq(263396013)

      merchant_id = 1
      expected = @item_repo.find_all_by_merchant_id(merchant_id)

      expect(expected).to eq([])
    end

    it 'can create a new item' do
      attributes = {
                    :id => nil,
                    :name => "llama smile sweater",
                    :description => "White sweater with a smiling llama",
                    :unit_price => 1999,
                    :merchant_id => 114488,
                    :created_at => Time.now,
                    :updated_at => Time.now
                   }

      @item_repo.create(attributes)

      expect(@item_repo.all.length).to eq(5)
      expect(@item_repo.all.last.id).to eq(263396210)
      expect(@item_repo.all.last.merchant_id).to eq(114488)
    end

    it 'can update an item with the corresponding id that has the provided attributes' do
      attributes = {
                    :name => "llama wink bikini",
                    :description => "It's like, a bikini with a llama on it that winks at you. Buy it.",
                    :unit_price => 962,
                   }

      id = 263396209
      @item_repo.update(id, attributes)

      expect(@item_repo.all.last.id).to eq(263396209)
      expect(@item_repo.all.last.name).to eq("llama wink bikini")
      expect(@item_repo.all.last.description).to eq("It's like, a bikini with a llama on it that winks at you. Buy it.")
      expect(@item_repo.all.last.unit_price).to eq(962)

      attributes = {:unit_price  => 42069}
      id = 263395617
      @item_repo.update(id, attributes)

      expect(@item_repo.all.first.unit_price).to eq(42069)
      expect(@item_repo.all.first.name).to eq('Glitter scrabble frames')
    end

    it 'can delete an item with the corresponding id' do
      id = 263396209
      item_repo.delete(id)
      
      expect(item_repo.all.last.id).to eq(263396013)
      expect(item_repo.all.last.name).to eq("Free standing Woden letters")
    end
  end
end
