require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_item_repo'
# make dummy data! this takes 1.5 secs to run
class InvoiceItemRepo < Minitest::Test
  def setup
    @ii_repo = InvoiceItemRepository.new
  end

  def test_it_exists_with_attributes
    assert_instance_of InvoiceItemRepository, @ii_repo
  end

  def test_it_returns_all_iis
    assert_equal 21830, @ii_repo.all.length
  end
end
