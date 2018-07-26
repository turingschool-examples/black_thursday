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
    @invoice1 = @invoice_repo.create(
      id:          1,
      customer_id: 2,
      merchant_id: 3,
      status:      'pending',
      created_at:  Time.now,
      updated_at:  Time.now
    )
    @invoice2 = @invoice_repo.create(
      id:          2,
      customer_id: 2,
      merchant_id: 3,
      status:      'shipped',
      created_at:  Time.now,
      updated_at:  Time.now
    )
    @invoice3 = @invoice_repo.create(
      customer_id: 3,
      merchant_id: 4,
      status:      'returned',
      created_at:  Time.now,
      updated_at:  Time.now
    )
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_can_create_invoices
    assert_instance_of Invoice, @invoice1
  end

  def test_it_returns_array_of_all_invoice_instances
    assert_equal [@invoice1, @invoice2, @invoice3], @invoice_repo.all
  end
end
