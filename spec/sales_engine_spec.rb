require './lib/sales_engine'


# This tests the SalesEngine class
RSpec.describe 'SalesEngine' do
  describe 'initialize' do
    it 'stores the hash for csv location' do
      se = SalesEngine.from_csv(
        items: './data/items.csv'
      )

      expect(se.class).to eq(SalesEngine)
    end

    it 'has an item repository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv'
      )

      expect(se.items).to be_an_instance_of(ItemRepository)
    end

    it 'has a merchant repository' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
      )
      expect(se.merchants).to be_an_instance_of(MerchantRepository)
    end

    it 'has an invoice repository' do
      se = SalesEngine.from_csv(
        invoices: './data/invoices.csv'
      )
      expect(se.invoices).to be_an_instance_of(InvoiceRepository)
    end

    it 'has an invoice_items repository' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )
      expect(se.invoice_items).to be_an_instance_of(InvoiceItemRepository)
    end

    it 'has an transaction repository' do
      se = SalesEngine.from_csv(
        transactions: './data/transactions.csv'
      )
      expect(se.transactions).to be_an_instance_of(TransactionRepository)
    end

    it 'has an customers repository' do
      se = SalesEngine.from_csv(
        customers: './data/customers.csv'
      )
      expect(se.customers).to be_an_instance_of(CustomerRepository)
    end
  end

  describe '#analyst' do
    it 'creates an instance of an analyst' do
      se = SalesEngine.from_csv(
        items: './data/items.csv',
        merchants: './data/merchants.csv',
        invoices: './data/invoices.csv',
        invoice_items: './data/invoice_items.csv',
        transactions: './data/transactions.csv',
        customers: './data/customers.csv'
      )

      sa = se.analyst

      expect(sa).to be_an_instance_of(SalesAnalyst)
    end
  end

  describe '#all_merchant_ids' do
    it 'returns an array of merchant ids' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
      )

      expect(se.all_merchant_ids.length).to eq(475)
    end
  end

  describe '#number_of_class' do
    it 'returns how many of a instance exist' do
      se = SalesEngine.from_csv(
        items: './data/items.csv'
      )

      expect(se.number_of_class(:items)).to eq(1367)
    end
  end
  describe '#self.from_csv' do
    it 'creates an instance of sales engine' do
      se = SalesEngine.from_csv(
        items: './data/items.csv'
      )

      expect(se.class).to eq(SalesEngine)
    end
  end
  describe '#csv_array' do
    it 'returns the csv array of the passed repository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv'
      )

      expect(se.csv_array(:items)).to eq(se.items.all)
    end
  end
  describe '#instance accessor methods' do
    it 'items accesses an items repository' do
      se = SalesEngine.from_csv(
        items: './data/items.csv'
      )

      expect(se.items.class).to eq(ItemRepository)
    end
    it 'merchants accesses an merchants repository' do
      se = SalesEngine.from_csv(
        merchants: './data/merchants.csv'
      )

      expect(se.merchants.class).to eq(MerchantRepository)
    end
    it 'invoices accesses an invoices repository' do
      se = SalesEngine.from_csv(
        invoices: './data/invoices.csv'
      )

      expect(se.invoices.class).to eq(InvoiceRepository)
    end
    it 'invoice_items accesses an invoice_items repository' do
      se = SalesEngine.from_csv(
        invoice_items: './data/invoice_items.csv'
      )

      expect(se.invoice_items.class).to eq(InvoiceItemRepository)
    end
    it 'transactions accesses an transactions repository' do
      se = SalesEngine.from_csv(
        transactions: './data/transactions.csv'
      )

      expect(se.transactions.class).to eq(TransactionRepository)
    end
    it 'customers accesses an customers repository' do
      se = SalesEngine.from_csv(
        customers: './data/customers.csv'
      )

      expect(se.customers.class).to eq(CustomerRepository)
    end
  end
end
