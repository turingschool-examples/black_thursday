require_relative 'test_helper.rb'
require_relative '../lib/invoice_repository.rb'
require 'csv'

class InvoiceRepositoryTest < Minitest::Test
  attr_accessor :repo
  
  def setup 
    @repo = InvoiceRepository.new('data/invoices.csv')
  end

  def test_exists 
    assert repo 
    assert_instance_of InvoiceRepository, repo
  end

  def test_returns_array_all_invoice_instances 
    assert_equal 4985, repo.all.length
  end
end
