require_relative 'spec_helper'

RSpec.describe InvoiceItemRepository do
  describe 'instantiation' do
    it "exists" do
      se = SalesEngine.from_csv({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoice_item: 'spec/fixtures/invoice_items.csv',
        invoices: 'spec/fixtures/invoices.csv'
        })

        iir = InvoiceItemRepository.new('spec/fixtures/invoice_item.csv', iir)
        # invoice_item = sales_engine.invoice_items.find_by_id(1)

        expect(iir).to be_a(InvoiceItemRepository)
      end
    end

  descirbe 'methods' do
    before :each do
      @sales_engine = SalesEngine.new({
        # items: 'spec/fixtures/items.csv',
        # merchants: 'spec/fixtures/merchants.csv',
        # invoice_item: 'spec/fixtures/invoice_items.csv',
        invoices: 'spec/fixtures/invoices.csv'
        })

        @iir = InvoiceItemRepository.new('spec/fixtures/items.csv', @sales_engine)
        # @iir.generate
      end

    it "generates InvoiceItemRepository " do
      expect(@item1.id).to eq(2)
      expect(@item1.name).to eq('pencils')
      expect(@item2.id).to eq(20)
      expect(@item2.name).to eq('mattress')
    end
  end
end
