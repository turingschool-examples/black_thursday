require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_analyst'

RSpec.describe SalesEngine do
  describe '#initialization' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })
    it 'exists' do
      expect(sales_engine).to be_instance_of(SalesEngine)
    end

    it 'creates instance of SalesAnalyst' do
      expect(sales_engine.analyst).to be_an_instance_of(SalesAnalyst)
    end

  end

  describe 'repository functionality' do
    sales_engine = SalesEngine.from_csv({
                                          :items     => "./data/items.csv",
                                          :merchants => "./data/merchants.csv",
                                          :invoices => "./data/invoices.csv",
                                          :customers => "./data/customers.csv",
                                          :invoice_items => "./data/invoice_items.csv",
                                          :transactions => "./data/transactions.csv"
                                          })

    it 'returns an object of class MerchantRepository' do
      expect(sales_engine.merchants).to be_an_instance_of(MerchantRepository)
    end

    it 'returns an object of class ItemRepository' do
      expect(sales_engine.items).to be_an_instance_of(ItemRepository)
    end

    it 'gets all merchants' do
      expect(sales_engine.get_all_merchants[1]).to be_an_instance_of(Merchant)
    end

    it 'gets all items' do
      expect(sales_engine.get_all_items[1]).to be_an_instance_of(Item)
    end

    it 'gets all invoices' do
      expect(sales_engine.get_all_invoices[1]).to be_an_instance_of(Invoice)
    end

    it 'gets all invoice items' do
      expect(sales_engine.get_all_invoice_items[1]).to be_an_instance_of(InvoiceItem)
    end

    it 'gets all transactions' do
      expect(sales_engine.get_all_transactions[1]).to be_an_instance_of(Transaction)
    end
  end
end
