require_relative 'test_helper'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    i = Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.new.to_s,
    :updated_at  => Time.new.to_s,
    })



    i2 = Invoice.new({
    :id          => 9,
    :customer_id => 38,
    :merchant_id => 93,
    :status      => "shipped",
    :created_at  => Time.new.to_s,
    :updated_at  => Time.new.to_s,
    })
end


end
