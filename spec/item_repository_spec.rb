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
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )
       
       ir = se.items

       expect(ir.all[3].name).to eq('Free standing Woden letters')
     end
   end
   describe '#find_by_id' do
     it 'returns an instance of an item' do
       se = SalesEngine.from_csv(
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_by_id('263397919').name).to eq('Le câlin')
     end
     it 'returns nil if no item has matching id' do
       se = SalesEngine.from_csv(
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_by_id('123')).to eq(nil)
     end
   end
   describe '#find_by_name' do
     it 'returns the item instance with a matching name' do
       se = SalesEngine.from_csv(
         :items     => './data/items.csv',
         :merchants => './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_by_name('Les raisons').id).to eq('263398653')
     end
     it 'returns nil if the name is not found' do
       se = SalesEngine.from_csv(
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_by_name('not here')).to eq(nil)
     end
   end
   describe '#find_all_with_description' do
     it 'finds all items whose description includes the string arugument' do
       se = SalesEngine.from_csv(
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_all_with_description('format')[2].name).to eq('Course contre la montre')
     end
     it 'returns an empty array if no items are found' do
       se = SalesEngine.from_csv(
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_all_with_description('101010100101010101')).to eq([])
     end
   end
   describe '#find_all_by_price' do
     it 'returns an array of all items with that price' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )

      ir = se.items

      expect(ir.find_all_by_price('4000')[2].name).to eq('Manchette cuir Galet')
    end
    it 'returns an empty array if no items are found' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )

      ir = se.items

      expect(ir.find_all_by_price('0000000')).to eq([])
    end
   end
   describe '#find_all_by_price_in_range' do
     it 'returns an array of all items with a price found in the range' do
       se = SalesEngine.from_csv(
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_all_by_price_in_range('100'..'1000')[5].name).to eq('Two tone blue stoneware pot')
     end
     it 'returns an empty array when no items are found' do
       se = SalesEngine.from_csv(
         items: './data/items.csv',
         merchants: './data/merchants.csv'
       )

       ir = se.items

       expect(ir.find_all_by_price_in_range('-3'..'-1')).to eq([])
     end
   end
end
