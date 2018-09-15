require_relative 'test_helper'

# TO DO  - change these to require require_relative
require './lib/invoice'
require './lib/invoice_repository'


class InvoiceRepositoryTest < Minitest::Test

  def setup
    path = './data/invoices.csv'
    @repo = InvoiceRepository.new(path)
    @first_item = @repo.all[0]
    # CSV - 1,1,12335938,pending,2009-02-07,2014-03-15
    @key = :"1"
    @value = {
              :customer_id    => "1",
              :merchant_id    => "12335938",
              :status         => "pending",
              :created_at     => "2016-01-11 09:34:06 UTC",
              :updated_at     => "2007-06-04 21:35:10 UTC"
    }
    # @expected_form_from_csv_parse = {key => value}
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @repo
  end

  def test_it_makes_and_gets_invoices
    assert_instance_of Array, @repo.all
    assert_instance_of Invoice,  @first_item
    assert_operator 1, :<=, @repo.all.count
  end

  def test_it_makes_invoices
    assert_equal 1,  @first_item.id
    assert_equal 1,  @first_item.customer_id
    assert_equal 12335938,  @first_item.merchant_id
    assert_equal "pending", @first_item.status
    assert_equal "2009-02-07", @first_item.created_at
    assert_equal "2014-03-15", @first_item.updated_at
  end

  def test_it_makes_a_formatted_hash
    # -- The new hash needs an additional column --
    new_column = {:id => 1}
    new_hash = new_column.merge(@value.dup)
    assert_equal new_hash, @repo.make_hash(@key, @value)
  end

end
