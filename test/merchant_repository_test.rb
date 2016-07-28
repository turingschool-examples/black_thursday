gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/merchant_repository"
require "./lib/sales_engine"


class MerchantRepositoryTest < MiniTest::Test
  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",})
  end

  # def test_csv_instance_variable_is_csv
  #   assert_equal true, @se.merchants.csv?
  # end
   def test_merchant_maker_does_its_job
     assert_equal 12334112, @se.merchants.all[1].id
     assert_equal "Shopin1901", @se.merchants.all[0].name
   end

   def test_all_returns_all_the_merchant_instances
     skip
     assert_equal "it_works", @se.merchants.all
   end

   def test_find_by_id

     assert_equal nil, @se.merchants.find_by_id(0)
     assert_equal 0,   @se.merchants.find_by_id(12335961)


   end

end
