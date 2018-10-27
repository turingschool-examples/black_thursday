require_relative './test_helper'


class TransactionRepositoryTest < Minitest::Test

  def test_it_exists
    tr = TransactionRepository.new('./test/data/invoice_test_data.csv')
    assert_instance_of TransactionRepository, tr
  end

end
