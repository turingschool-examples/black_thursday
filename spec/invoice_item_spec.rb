require 'CSV'
require './lib/item'
require 'BigDecimal'
require 'pry'


RSpec.describe InvoiceItem do
  before :each do
    @x = Time.now
    @ii = InvoiceItem.new({
        :id => 6,
        :item_id => 7,
        :invoice_id => 8,
        :quantity => 1,
        :unit_price => BigDecimal(10.99, 4),
        :created_at => Time.now,
        :updated_at => Time.now
        })
      end
      
  it 'exists' do
    expect(@ii).to be_a InvoiceItem
  end
end
