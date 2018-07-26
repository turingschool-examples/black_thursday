# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/emoji'

require './lib/invoice_repository'

# Invoice repository class
class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoice_repo = InvoiceRepository.new
    @invoice1 = {
      id:          1,
      customer_id: 2,
      merchant_id: 3,
      status:      'pending',
      created_at:  Time.now,
      updated_at:  Time.now
    }
    @invoice2 = {
      id:          2,
      customer_id: 2,
      merchant_id: 3,
      status:      'shipped',
      created_at:  Time.now,
      updated_at:  Time.now
    }
    @invoice3 = {
      customer_id: 3,
      merchant_id: 4,
      status:      'returned',
      created_at:  Time.now,
      updated_at:  Time.now
    }
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end
end
