# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'
require 'bigdecimal'
require 'time'

require './lib/invoice_item_repository'

# InvoiceItemRepository test class
class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @iir = InvoiceItemRepository.new
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

end
