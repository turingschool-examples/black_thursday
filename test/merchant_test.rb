require "minitest/autorun"
require "./lib/merchant"
require "csv"
require "pp"


class MerchantTest < Minitest::Test


  def test_it_exists
    merch = Merchant.new({:id => 5, :name => "Turing School"})
    assert merch
    # assert se.items.include?("id,name,description")
  end

  def test_has_name
    merch = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", merch.name
    # assert se.items.include?("id,name,description")
  end

  def test_it_has_id
    merch = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, merch.id
    # assert se.items.include?("id,name,description")
  end


  #
  # def test_if_we_can_create_merchant_objects
  #   contents = CSV.open "./data/merchants.csv", headers: true, header_converters: :symbol
  #
  #   all_merchants = contents.map do |row|
  #     Merchant.new({:id => row[:id], :name => row[:name]})
  #   end
  #   all_merchants.each { |merchant| puts merchant.name }
  # end

end
