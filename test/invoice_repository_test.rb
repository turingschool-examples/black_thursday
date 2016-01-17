require_relative '../lib/invoice_repository'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class InvoiceRepositoryTest < Minitest::Test

  def test_class_exist
    assert InvoiceRepository
  end

end
