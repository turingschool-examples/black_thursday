
# TO DO - Add these to simplecov
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

# TO DO  - change these to require require_relative
require './lib/invoice'
require './lib/invoice_repository'


class InvoiceRepositoryTest < Minitest::Test

  def setup
    @path = './data/invoices.csv'
    @repo = InvoiceRepository.new(@path)
    @first_item = @repo.all[0]
    @key = :"6"
    @value = {
              :id             => "6",
              :customer_id    => "7",
              :merchant_id    => "8",
              :status         => "pending",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    @expected_form_from_csv_parse = {@key => @value}
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @repo
  end

  def test_it_makes_and_gets_invoices
    assert_instance_of Array, @repo.all
    assert_instance_of Invoice,  @repo.all[0]
    assert_instance_of Invoice,  @repo.all[1000]
  end

  def test_it_makes_invoices
    @big_decimal = BigDecimal.new(1200, 4)
    assert_equal 1,  @first_item.id
    assert_equal "1",  @first_item.customer_id
    assert_equal "12335938",  @first_item.merchant_id
    assert_equal "pending", @first_item.status
    assert_equal "2009-02-07", @first_item.created_at
    assert_equal "2014-03-15", @first_item.updated_at
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 263395237}
    new_hash = new_column.merge(@value.dup)
    assert_equal new_hash, @repo.make_hash(@key, @value)
  end

  # def test_it_can_find_all
  #   assert_equal 1367, @repo.all.count
  # end

  # def test_it_can_find_by_id
  #   assert_equal 263395617, @repo.find_by_id("263395617").id
  # end

  # def test_it_can_find_all_by_name
  #   assert_equal [@first_item], @repo.find_all_by_name("510+ RealPush Icon Set")
  # end

  # def test_it_can_find_highest_id
  #   assert_equal 263567474, @repo.find_by_highest_id.id
  # end

  # def test_it_can_create_new_merchant_instance_from_attribute_hash
  #   new_item = {
  #     :id             => 0,
  #     :name           => "511+ RealPush Icon Set",
  #     :description    => "You&#39;ve got a total socialmedia iconset!", # NOTE - excerpt!
  #     :unit_price     => BigDecimal(10.99,4),
  #     :created_at     => Time.now,
  #     :updated_at     => Time.now,
  #     :merchant_id    => 2
  #   }

  #   expected = Item.new({
  #     :id             => 263567475,
  #     :name           => "511+ RealPush Icon Set",
  #     :description    => "You&#39;ve got a total socialmedia iconset!",
  #     :unit_price     => BigDecimal(10.99,4),
  #     :created_at     => Time.now,
  #     :updated_at     => Time.now,
  #     :merchant_id    =>2
  #   })
    
    
    
  # end

end
