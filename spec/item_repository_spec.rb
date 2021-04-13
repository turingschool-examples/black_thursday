require './lib/sales_engine'

RSpec.describe 'ItemRepository' do
  describe '#initialize' do
    it 'creates an instance of ItemRepository' do
      se = SalesEngine.from_csv(
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'
      )

      ir = se.items

      expect(ir.class).to eq(ItemRepository)
    end
    it 'is created with an array of items' do
      se = SalesEngine.from_csv(
        :items     => './data/items.csv',
        :merchants => './data/merchants.csv'
      )

      ir = se.items

      expect(ir.item_array.class).to eq(Array)
      expect(ir.item_array[0].class).to eq(Item)
    end
   end
   describe '#all' do
     it 'returns an array of all items created so far' do
       se = SalesEngine.from_csv(
         :items     => './data/items.csv',
         :merchants => './data/merchants.csv'
       )

       ir = se.items

       expect(ir.all[3].name).to eq('Free standing Woden letters')
     end
   end
   describe '#find_by_id' do
     it 'returns an instance of an item' do
       se = SalesEngine.from_csv(
         :items     => './data/items.csv',
         :merchants => './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_by_id('263397919').name).to eq('Le câlin')
     end
     it 'returns nil if no item has matching id' do
       se = SalesEngine.from_csv(
         :items     => './data/items.csv',
         :merchants => './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_by_id('123')).to eq(nil)
     end
   end
end
