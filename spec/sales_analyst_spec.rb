require_relative 'spec_helper'

RSpec.describe SalesAnalyst do

  context 'iteration1' do
    before :each do
      @paths = {
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions => "./data/transactions.csv",
        :customers => "./data/customers.csv"
      }
      @se = SalesEngine.from_csv(@paths)
    end

    it 'can initialize from SalesEngine #.from_csv class method' do
      sales_analyst = @se.analyst

      expect(sales_analyst.class).to eq(SalesAnalyst)
    end

    it 'can read repos from SalesEngine' do
      sales_analyst = @se.analyst

      expect(sales_analyst.items.class).to eq(ItemRepository)
      expect(sales_analyst.merchants.class).to eq(MerchantRepository)
      expect(sales_analyst.invoices.class).to eq(InvoiceRepository)
      expect(sales_analyst.invoice_items.class).to eq(InvoiceItemRepository)
      expect(sales_analyst.transactions.class).to eq(TransactionRepository)
      expect(sales_analyst.customers.class).to eq(CustomerRepository)
      expect(sales_analyst.engine.class).to eq(SalesEngine)
    end

    it 'returns average items per merchant' do
      sales_analyst = @se.analyst
      result = sales_analyst.average_items_per_merchant

      expect(result).to eq 2.88
      expect(result.class).to eq Float
    end

    it 'returns standard deviation from average items per merchant' do
      sales_analyst = @se.analyst
      result = sales_analyst.average_items_per_merchant_standard_deviation

      expect(result).to eq 3.26
      expect(result.class).to eq Float
    end

    it 'returns merchants more than one standard deviation above the average' do
      sales_analyst = @se.analyst
      result = sales_analyst.merchants_with_high_item_count

      expect(result.length).to eq 52
      expect(result.first.class).to eq Merchant
    end

    it 'returns the average item price for a given merchant' do
      sales_analyst = @se.analyst
      merchant_id = 12334105
      result = sales_analyst.average_item_price_for_merchant(merchant_id)

      expect(result).to eq 16.66
      expect(result.class).to eq BigDecimal
    end

    xit 'returns the average price for all merchants' do
      sales_analyst = @se.analyst
      result = sales_analyst.average_average_price_per_merchant

      expect(result).to eq 350.29
      expect(result.class).to eq BigDecimal
    end

    it 'returns items that are two standard deviations above the average price' do
      sales_analyst = @se.analyst
      result = sales_analyst.golden_items

      expect(result.length).to eq 5
      expect(result.first.class).to eq Item
    end
  end

  context 'iteration2' do
    before :each do
      @paths = {
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv"
      }
      @se = SalesEngine.from_csv(@paths)
    end

    xit 'returns average number of invoices per merchant' do
      sales_analyst = @se.analyst
      result = sales_analyst.average_invoices_per_merchant

      expect(result).to eq 10.49
      expect(result.class).to eq Float
    end

    xit 'returns the standard deviation from average invoices per merchant' do
      sales_analyst = @se.analyst
      result = sales_analyst.average_invoices_per_merchant_standard_deviation

      expect(result).to eq 3.29
      expect(result.class).to eq Float
    end

    xit 'returns merchants that are two standard deviations above average' do
      sales_analyst = @se.analyst
      result = sales_analyst.top_merchants_by_invoice_count

      expect(result.length).to eq 12
      expect(result.first.class).to eq Merchant
    end

    xit 'returns merchants that are two standard deviations below average' do
      sales_analyst = @se.analyst
      result = sales_analyst.bottom_merchants_by_invoice_count

      expect(result.length).to eq 4
      expect(result.first.class).to eq Merchant
    end

    xit 'returns days with an invoice count more than one standard deviation above average' do
      sales_analyst = @se.analyst
      result = sales_analyst.top_days_by_invoice_count

      expect(result.length).to eq 1
      expect(result.first).to eq "Wednesday"
      expect(result.first.class).to eq String
    end

    xit 'returns the percentage of invoices with given status' do
      sales_analyst = @se.analyst

      result = sales_analyst.invoice_status(:pending)
      expect(result).to eq 29.55

      result = sales_analyst.invoice_status(:shipped)
      expect(result).to eq 56.95

      result = sales_analyst.invoice_status(:returned)
      expect(result).to eq 13.5
    end
  end

end
