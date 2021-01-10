require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repo'

class InvoiceItemRepo < Minitest::Test
  def setup
    @ii_repo = InvoiceItemRepository.new('./test/dummy_data/invoice_item_dummies.csv')
  end

  def test_it_exists_with_attributes
    assert_instance_of InvoiceItemRepository, @ii_repo
  end

  def test_it_returns_all_iis
    assert_equal 17, @ii_repo.all.length
    assert_equal Array, @ii_repo.all.class
  end
end
