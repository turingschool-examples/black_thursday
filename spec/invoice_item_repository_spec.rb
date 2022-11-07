require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'
require 'bigdecimal'

RSpec.describe InvoiceItemRepository do 
  let(:iir) { InvoiceItemRepository.new }

  let(:invoice_item_1) { InvoiceItem.new({
                                          :id => 6,
                                          :item_id => 7,
                                          :invoice_id => 8,
                                          :quantity => 1,
                                          :unit_price => BigDecimal("1099",4),
                                          :created_at => Time.now,
                                          :updated_at => Time.now
                                        })}
  let(:invoice_item_2) { InvoiceItem.new({
                                          :id => 1,
                                          :item_id => 2,
                                          :invoice_id => 3,
                                          :quantity => 2,
                                          :unit_price => BigDecimal("1299",4),
                                          :created_at => Time.now,
                                          :updated_at => Time.now
                                        })}
  let(:invoice_item_3) { InvoiceItem.new({
                                          :id => 9,
                                          :item_id => 10,
                                          :invoice_id => 11,
                                          :quantity => 3,
                                          :unit_price => BigDecimal("1599",4),
                                          :created_at => Time.now,
                                          :updated_at => Time.now
                                        })}

  describe '#initialize' do
    it 'exists' do
      expect(iir).to be_a(InvoiceItemRepository)
    end
  end
                                      
  describe 'all' do
    it 'starts as an empty array' do
      expect(iir.all).to eq([])
    end
  end
end