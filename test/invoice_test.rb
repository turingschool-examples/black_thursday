require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice'


class InvoiceTest < MiniTest::Test

  def setup
    @repo = "repo"
    @i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      }, @repo)
  end

  def test_it_exists

    assert_instance_of Invoice, @i
  end

end
