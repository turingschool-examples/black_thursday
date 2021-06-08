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

        iir = InvoiceItemRepository.new('spec/fixtures/invoice_items.csv', se)
        # invoice_item = sales_engine.invoice_items.find_by_id(1)

        expect(iir).to be_a(InvoiceItemRepository)
      end
    end

  describe 'methods' do
    before :each do
      @sales_engine = SalesEngine.new({
        items: 'spec/fixtures/items.csv',
        merchants: 'spec/fixtures/merchants.csv',
        invoice_item: 'spec/fixtures/invoice_items.csv',
        invoices: 'spec/fixtures/invoices.csv'
        })

        @iir = InvoiceItemRepository.new('spec/fixtures/invoice_items.csv', @sales_engine)
        @invoice_item1 = @iir.all[0]
        @invoice_item2 = @iir.all[1]
        @invoice_item3 = @iir.all[2]
        @invoice_item4 = @iir.all[3]
        @invoice_item5 = @iir.all[4]
        @invoice_item6 = @iir.all[5]
        @invoice_item7 = @iir.all[6]
        @invoice_item8 = @iir.all[7]
        @invoice_item9 = @iir.all[8]
        @invoice_item10 = @iir.all[9]
        @invoice_item11 = @iir.all[10]
        @invoice_item12 = @iir.all[11]
        @invoice_item13 = @iir.all[12]
        @invoice_item14 = @iir.all[13]
        @invoice_item15 = @iir.all[14]
        @invoice_item16 = @iir.all[15]
        @invoice_item17 = @iir.all[16]
        @invoice_item18 = @iir.all[17]
        @invoice_item19 = @iir.all[18]
        @invoice_item20 = @iir.all[19]
      end

    it "generates InvoiceItemRepository " do
      expect(@invoice_item1.id).to eq(1)
      expect(@invoice_item1.item_id).to eq(263519844)
      expect(@invoice_item1.invoice_id).to eq(1)
      expect(@invoice_item1.quantity).to eq(5)
      expect(@invoice_item1.unit_price).to eq(13635)
    end

    it 'finds invoice_item by id or return nil' do
      expect(@iir.find_by_id(1)).to eq(@invoice_item1)
      expect(@iir.find_by_id(2)).to eq(@invoice_item2)
      expect(@iir.find_by_id(1000000)).to eq(nil)
    end
  end
end
