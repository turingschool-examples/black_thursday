require './lib/item'
require 'time'
require 'bigdecimal'

RSpec.describe Invoice do

  it "exists" do
    inv = Invoice.new({ :id          => 1,
     :name        => "Pencil",
     :description => "You can use it to write things",
     :unit_price  => BigDecimal(10.99,4),
     :created_at  => Time.now,
     :updated_at  => Time.now,
     :merchant_id => 2})
  end
end
