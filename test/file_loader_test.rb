require_relative './test_helper'
require_relative '../lib/file_loader'
require_relative '../lib/sales_engine'

class FileLoaderTest < Minitest::Test

  def test_it_can_touch_sales_engine_and_repos
    se = SalesEngine.new("empty")
    fl = FileLoader.new(se)
    assert_equal ItemRepo, fl.item_repo.class
    assert_equal MerchantRepo, fl.merchant_repo.class
    assert_equal InvoiceRepo, fl.invoice_repo.class
    assert_equal InvoiceItemRepo, fl.invoice_item_repo.class
    assert_equal TransactionRepo, fl.transaction_repo.class
    assert_equal CustomerRepo, fl.customer_repo.class
  end

  def test_file_will_load_to_specific_repo
    se = SalesEngine.new("empty")
    fl = FileLoader.new(se)
    file_path = {:merchants => './test/support/single_merchant.csv'}
    fl.load_repos_from_csv(file_path)
    assert_equal 1, se.merchant_repo.all.count
    assert_equal fl.merchant_repo, se.merchant_repo
  end

  def test_it_load_the_other_repos
    se = SalesEngine.new("empty")
    fl = FileLoader.new(se)
    file_path_details = {
      :merchants => './test/support/single_merchant.csv',
      :items => './test/support/single_item.csv',
      :invoices => './test/support/single_invoice.csv',
      :invoice_items => './test/support/single_invoice_item.csv',
      :transactions => './test/support/single_transaction.csv',
      :customers => './test/support/single_customer.csv'
    }
    fl.load_repos_from_csv(file_path_details)
    assert_equal 1, se.merchant_repo.all.count
    assert_equal 1, se.item_repo.all.count
    assert_equal 1, se.invoice_repo.all.count
    assert_equal 1, se.invoice_item_repo.all.count
    assert_equal 1, se.transaction_repo.all.count
    assert_equal 1, se.customer_repo.all.count
  end

end
