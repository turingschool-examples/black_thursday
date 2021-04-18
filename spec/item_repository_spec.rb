require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/item_repository'
require 'bigdecimal'

RSpec.describe ItemRepository do
  describe '#initialize' do
    it 'exists' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      expect(ir).to be_instance_of(ItemRepository)
    end
    it 'has items' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      expect(ir.items.count).to eq(1367)
    end
  end
  describe '#make_items' do
    it 'makes_items' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      expect(ir.items.first).to be_instance_of(Item)
    end
  end
  describe '#all' do
    it 'contains all the items' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      expect(ir.all.count).to eq(1367)
    end
  end
  describe '#find_by_id' do
    it 'finds items by id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      test_item = Item.new({
        id:            '1',
        name:         'Cool Stuff',
        description:  'supaaa cool',
        unit_price:   '1300',
        merchant_id:  '12334185',
        created_at:   '2016-01-11 11:51:37 UTC',
        updated_at:   '1993-09-29 11:56:40 UTC'
        },
        ir)
      ir.items << test_item
      expect(ir.find_by_id(1)).to eq(test_item)
      expect(ir.find_by_id(7)).to eq(nil)
    end
  end
  describe '#find_by_name' do
    it 'finds items by name' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      test_item = Item.new({
        id: '1',
        name: 'Cool Stuff',
        description:  'supaaa cool',
        unit_price:   '1300',
        merchant_id:  '12334185',
        created_at:   '2016-01-11 11:51:37 UTC',
        updated_at:   '1993-09-29 11:56:40 UTC'
        },
        ir)
      ir.items << test_item
      expect(ir.find_by_name('CoOL StUfF')).to eq(test_item)
      expect(ir.find_by_name('neato')).to eq(nil)
    end
  end
  describe '#find_all_with_description' do
    it 'finds items by description' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      test_item = Item.new({
        id:            '1',
        name:          'Cool Stuff',
        description:  'supaaa cool',
        unit_price:   '1300',
        merchant_id:  '12334185',
        created_at:   '2016-01-11 11:51:37 UTC',
        updated_at:   '1993-09-29 11:56:40 UTC'
        },
        ir)
      ir.items << test_item
      expect(ir.find_all_with_description('sUPaAa')).to eq([test_item])
      expect(ir.find_all_with_description('neato burrito')).to eq([])
    end
  end
  describe '#find_all_by_price' do
    it 'finds items by price' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      test_item = Item.new({
        id:           '1',
        name:         'Cool Stuff',
        description:  'supaaa cool',
        unit_price:   '12365451',
        merchant_id:  '12334185',
        created_at:   '2016-01-11 11:51:37 UTC',
        updated_at:   '1993-09-29 11:56:40 UTC'
        },
        ir)
      ir.items << test_item
      price_1 = BigDecimal(12365451) / 100
      price_2 = BigDecimal(7541234541)
      expect(ir.find_all_by_price(price_1)).to eq([test_item])
      expect(ir.find_all_by_price(7541234541)).to eq([])
    end
  end
  describe '#find_all_by_price_in_range' do
    it 'finds items by price range' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      test_item = Item.new({
        id: '1',
        name:         'Cool Stuff',
        description:  'supaaa cool',
        unit_price:   '1357',
        merchant_id:  '12334185',
        created_at:   '2016-01-11 11:51:37 UTC',
        updated_at:   '1993-09-29 11:56:40 UTC'
        },
        ir)
      ir.items << test_item
      range1 = (1000.00..1500.00)
      range2 = (154503..245754)
      expect(ir.find_all_by_price_in_range(range1).count).to eq(19)
      expect(ir.find_all_by_price_in_range(range2)).to eq([])
    end
  end
  describe '#find_all_by_merchant_id' do
    it 'finds items by merchant id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      test_item = Item.new({
                              id:           '1',
                              name:         'Cool Stuff',
                              description:  'supaaa cool',
                              unit_price:   '1357',
                              merchant_id:  '123456987',
                              created_at:   '2016-01-11 11:51:37 UTC',
                              updated_at:   '1993-09-29 11:56:40 UTC'
                            }, ir)
      ir.items << test_item
      expect(ir.find_all_by_merchant_id(123456987)).to eq([test_item])
      expect(ir.find_all_by_merchant_id(4)).to eq([])
    end
  end
  describe '#generate_new_id' do
    it 'create a new item id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      expect(ir.generate_new_id).to eq(263567475)
    end
  end
  describe '#create' do
    it 'create a new item instance' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      attributes = {
        name:         'Cool Stuff',
        description:  'supaaa cool',
        unit_price:   '1357',
        merchant_id:  '123456987',
        created_at:   '2016-01-11 11:51:37 UTC',
        updated_at:   '1993-09-29 11:56:40 UTC'
      }
      ir.create(attributes)
      expected = ir.find_by_id(263567475)
      expect(expected.name).to eq('Cool Stuff')
    end
  end
  describe '#update' do
    it 'updates items attributes' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      attributes = {
        name:         'Cool Stuff',
        description:  'supaaa cool',
        unit_price:   '1357'
      }
      test_item = ir.find_by_id(263567292)
      ir.update(263567292, attributes)
      expect(test_item.name).to eq('Cool Stuff')
      expect(test_item.description).to eq('supaaa cool')
      expect(test_item.unit_price).to eq(0.1357e2)
      expect(test_item.merchant_id).to eq(12336050)
      expect(test_item.created_at.year).to eq(2016)
      expect(test_item.updated_at.year).to eq(2021)
    end
  end

  describe '#delete' do
    it 'delete a specified item from the items array' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = ItemRepository.new('./data/items.csv', mock_sales_engine)
      ir.delete(263567292)
      expect(ir.items.count).to eq(1366)
    end
  end

  describe '#items_per_merchant' do
    it 'creates a hash of merchant id keys and an item count for values' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      hash = {
              12334105 => 2,
              12345678 => 1,
              12334113 => 1,
              12333333 => 1
              }
      expect(ir.items_per_merchant).to eq(hash)
    end
  end

  describe '#average_items_per_merchant' do
    it 'can find the average number of items per merchant' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      expect(ir.average_items_per_merchant).to eq(1.25)
    end
  end

  describe '#average_items_per_merchant_standard_deviation' do
    it 'can find the average item per merchant standard deviation' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      expect(ir.average_items_per_merchant_standard_deviation).to eq(0.5)
    end
  end

  describe '#merchants_with_high_item_count' do
    it 'can find which merchants sell the most items' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      expect(ir.merchants_with_high_item_count[0].name).to eq("Shopin1901")
    end
  end

  describe '#average_item_price_for_merchant' do
    it 'averages the item price for merchant' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      expect(ir.average_item_price_for_merchant(12334105)).to eq(14)
    end
  end

  describe '#average_average_price_per_merchant' do
    it 'sum the averages and finds average price across all merchants' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      expect(ir.average_average_price_per_merchant).to eq(0.1862e2)
    end
  end

  describe '#item_price_hash' do
    it 'creates a hash of item id keys and unit price values' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      hash ={
              263395617 => 0.13e2,
              263395618 => 0.15e2,
              263395721 => 0.135e2,
              263396013 => 0.7e1,
              263397843 => 0.4e2
            }
      expect(ir.item_price_hash).to eq(hash)
    end
  end

  describe '#golden_items' do
    it 'finds items greater than 2 std dev above average item price' do
      se = SalesEngine.from_csv({
          items: './spec/truncated_data/items_truncated.csv',
          merchants: './spec/truncated_data/merchants_truncated.csv',
          invoices: './spec/truncated_data/invoices_truncated.csv'
                                })
      ir = ItemRepository.new('./spec/truncated_data/items_truncated.csv', se)

      expect(ir.golden_items).to eq([])
    end
  end
end
