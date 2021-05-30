require './lib/sales_engine'

RSpec.describe 'ItemRepository' do
  before(:all) do
    se = SalesEngine.from_csv(
      items: './data/items.csv'
    )

    @ir = se.items
  end
  describe '#initialize' do
    it 'creates an instance of ItemRepository' do

      expect(@ir.class).to eq(ItemRepository)
    end
    it 'is created with an array of items' do

      expect(@ir.all.class).to eq(Array)
      expect(@ir.all[0].class).to eq(Item)
    end
  end
  describe '#all' do
    it 'returns an array of all items created so far' do

      expect(@ir.all[3].name).to eq('Free standing Woden letters')
    end
  end
  describe '#find_by_id' do
    it 'returns an instance of an item' do

      expect(@ir.find_by_id(263397919).name).to eq('Le câlin')
    end
    it 'returns nil if no item has matching id' do

      expect(@ir.find_by_id(123)).to eq(nil)
    end
  end
  describe '#find_by_name' do
    it 'returns the item instance with a matching name' do

      expect(@ir.find_by_name('Les raisons').id).to eq(263398653)
    end
    it 'returns nil if the name is not found' do

      expect(@ir.find_by_name('not here')).to eq(nil)
    end
  end
  describe '#find_all_with_description' do
    it 'finds all items whose description includes the string arugument' do

      expect(@ir.find_all_with_description('format')[2].name).to eq('Course contre la montre')
    end
    it 'returns an empty array if no items are found' do

      expect(@ir.find_all_with_description('101010100101010101')).to eq([])
    end
  end
  describe '#find_all_by_price' do
    it 'returns an array of all items with that price' do

      expect(@ir.find_all_by_price(40.00)[2].name).to eq('Manchette cuir Galet')
    end
    it 'returns an empty array if no items are found' do

      expect(@ir.find_all_by_price(-123.45)).to eq([])
    end
  end

  describe '#find_all_by_price_in_range' do
    it 'returns an array of all items with a price found in the range' do

      actual = @ir.find_all_by_price_in_range(1.00..10.00)[5].name
      expected = 'Two tone blue stoneware pot'

      expect(actual).to eq(expected)
    end
    it 'returns an empty array when no items are found' do

      expect(@ir.find_all_by_price_in_range(-3..-1)).to eq([])
    end
  end
  describe '#find_all_by_merchant_id' do
      it 'returns all items with that merchant as a seller' do

        expect(@ir.find_all_by_merchant_id(12334951)[0].name).to eq('The Contender')
      end
      it 'returns an empty array when no merchants are found' do

        expect(@ir.find_all_by_merchant_id(1010101001010101)).to eq([])
      end
  end
  describe '#max_id_number_new' do
    it 'returns an id number one larger than the previous max' do


      expect(@ir.max_id_number_new).to eq(263567475)
    end
  end
  describe '#create' do
    it 'creates an instance of an item' do

      item = @ir.create(
        name:         'Pencil',
        description:  'You can use it to write things',
        unit_price:    10.99,
        merchant_id:   2
        )

      expect(item.class).to eq(Item)
      expect(item.name).to eq('Pencil')
      expect(item.description).to eq('You can use it to write things')
      expect(item.unit_price).to eq(10.99)
      expect(item.merchant_id).to eq(2)
    end
  end
  describe '#update' do
    it 'changes the attributes of an item identified by its id' do

      @ir.update(
        263430973,
        name: 'Basket #18909',
        description: 'A basket',
        unit_price: 2.00
      )

      expect(@ir.find_by_id(263430973).name).to eq('Basket #18909')
      expect(@ir.find_by_id(263430973).description).to eq('A basket')
      expect(@ir.find_by_id(263430973).unit_price).to eq(2.00)
      expect(@ir.find_by_id(263430973).updated_at).not_to eq(@ir.find_by_id(263430973).created_at)
    end
  end
end
