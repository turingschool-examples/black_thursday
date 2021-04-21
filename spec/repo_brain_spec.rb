require 'simplecov'
SimpleCov.start
require './lib/sales_engine'
require './lib/merchant_repository'
require './lib/item_repository'
require './lib/invoice_repository'

RSpec.describe RepoBrain do

  describe '#find_by_id' do
    it 'finds by id or returns nil' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(RepoBrain.find_by_id(3, 'id', mr.merchants)).to eq(nil)
      expect(RepoBrain.find_by_id(12334113, 'id', mr.merchants)).to be_a(Merchant)
    end
  end


  describe '#find_all_by_id' do
    it 'finds all by id' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)
      test_invoice1 = Invoice.new({
                                    id: '1234567890',
                                    customer_id: '456789',
                                    merchant_id: '234567890',
                                    status: 'pending',
                                    created_at: '2016-01-11 11:51:37 UTC',
                                    updated_at: '1993-09-29 11:56:40 UTC'
                                  },
                                    ir
                                 )
      test_invoice2 = Invoice.new({
                                  id: '1234567820',
                                  customer_id: '456789',
                                  merchant_id: '234567890',
                                  status: 'pending',
                                  created_at: '2016-01-11 11:51:37 UTC',
                                  updated_at: '1993-09-29 11:56:40 UTC'
                                  },
                                  ir
                                 )
      ir.invoices << test_invoice1
      ir.invoices << test_invoice2

      expect(RepoBrain.find_all_by_id(234567890, 'merchant_id', ir.invoices)).to eq([test_invoice1, test_invoice2])
      expect(RepoBrain.find_all_by_id(20, 'merchant_id', ir.invoices)).to eq([])
    end
  end

    describe '#find_all_by_symbol' do
    it 'finds objects with specified symbol' do
      mock_sales_engine = instance_double('SalesEngine')
      ir = InvoiceRepository.new('./data/invoices.csv', mock_sales_engine)

      expect(RepoBrain.find_all_by_symbol('pending', 'status', ir.invoices).count).to eq(1473)
      expect(RepoBrain.find_all_by_symbol('hot dog', 'status', ir.invoices)).to eq([])
    end
  end

  describe '#find_all_by_full_string' do
    it 'finds all records with a given full string' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(RepoBrain.find_by_full_string('jsdhflihsdlif', 'name', mr.merchants)).to eq(nil)
      expect(RepoBrain.find_by_full_string('CandisArt', 'name', mr.merchants)).to be_a(Merchant)
    end
  end

  describe '#find_all_by_partial_string' do
    it 'finds objects by a partial string' do
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

      expect(RepoBrain.find_all_by_partial_string('sUPaAa', 'description', ir.items)).to eq([test_item])
      expect(RepoBrain.find_all_by_partial_string('neato burritto', 'description', ir.items)).to eq([])
    end
  end

  describe '#generate_new_id' do
    it 'generates a new id for a repo' do
      mock_sales_engine = instance_double('SalesEngine')
      truncated_merchants = './spec/truncated_data/merchants_truncated.csv'
      mr = MerchantRepository.new(truncated_merchants, mock_sales_engine)

      expect(RepoBrain.generate_new_id(mr.merchants)).to eq(12334114)
    end
  end
end
