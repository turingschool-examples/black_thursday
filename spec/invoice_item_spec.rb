require './lib/invoice_item'
require 'bigdecimal'

RSpec.describe 'InvoiceItem' do
  describe '#initialize' do
    before do
      @ii = InvoiceItem.new({
        :id          => 6,
        :item_id     => 7,
        :invoice_id  => 8,
        :quantity    => 1,
        :unit_price  => BigDecimal(10.99,4),
        :created_at  => Time.now,
        :updated_at  => Time.now,
      })
    end

    it 'is an instance of InvoiceItem' do
      expect(@ii).to be_an_instance_of InvoiceItem
    end 
  end


end
