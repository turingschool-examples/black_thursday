require_relative 'test_helper'
require_relative '../lib/invoice_repo'

class InvoiceRepoTest < Minitest::Test
  attr_reader :invoice_repo,
              :parent

  def setup
    data = LoadFile.load('./test/fixture_data/invoice_repo_fixture.csv')
    @parent = Minitest::Mock.new
    @invoice_repo = InvoiceRepo.new(data, parent)
  end

  def test_it_exists
    assert_instance_of InvoiceRepo, invoice_repo
  end
  
end
