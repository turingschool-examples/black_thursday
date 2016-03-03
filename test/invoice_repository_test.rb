gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/invoice'
require_relative '../lib/invoice_repository'

class InvoiceRepositoryClassTest < Minitest::Test

  def setup
    
  end

  def test_can_create_an_invoice_repository
    assert InvoiceRepository.new

  end

  def test_can_find_an_invoice_by_its_id
    assert_equal
