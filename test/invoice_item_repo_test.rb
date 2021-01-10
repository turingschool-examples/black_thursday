require 'minitest/autorun'
require 'minitest/pride'

class InvoiceItemRepo < Minitest::Test
  def setup
    @ii_repo = InvoiceItemRepository.new
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @ii_repo
  end
end
