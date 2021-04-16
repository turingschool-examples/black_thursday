require './lib/sales_engine'


# This tests the SalesEngine class
RSpec.describe 'SalesEngine' do
  describe 'initialize' do
    it 'stores the hash for csv location' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )

      expect(se.class).to eq(SalesEngine)
    end

    it 'has an item repository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )

      expect(se.items).to be_an_instance_of(ItemRepository)
    end

    it 'has a merchant repository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )
      expect(se.merchants).to be_an_instance_of(MerchantRepository)
    end

    it 'has an invoice repository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoice: './data/invoices.csv'
      )
      expect(se.invoices).to be_an_instance_of(InvoiceRepository)
    end
  end

  describe '#analyst' do
    it 'creates an instance of an analyst' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )

      sa = se.analyst

      expect(sa).to be_an_instance_of(SalesAnalyst)
    end
  end

  describe '#all_merchant_ids' do
    it 'returns an array of merchant ids' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv'
      )

      expect(se.all_merchant_ids.length).to eq(425)
    end
  end
end
