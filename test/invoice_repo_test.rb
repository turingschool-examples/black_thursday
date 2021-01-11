require 'minitest/autorun'
require 'minitest/pride'
require './lib/invoice_repo'
require './lib/sales_engine'

require './lib/cleaner'
require './lib/sales_engine'

class InvoiceRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({items: "./data/items.csv"})
    @invoice_repo = InvoiceRepository.new(@sales_engine)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @invoice_repo
  end

  def test_it_has_attributes
    skip
    assert_equal [], @invoice_repo.invoices
  end

  def test_it_returns_all_invoices
    assert_equal 4985, @invoice_repo.all.length
  end

  def test_it_can_find_by_id
    invoice_id = 3452
    expected = @invoice_repo.find_by_id(invoice_id)
    assert_equal invoice_id, expected.id
    assert_equal 12335690, expected.merchant_id
    assert_equal 679, expected.customer_id
    assert_equal :pending, expected.status

    invoice_id = 5000
    expected = @invoice_repo.find_by_id(invoice_id)
    assert_nil expected
  end

  def test_it_finds_all_by_customer_id
    customer_id = 300
    expected = @invoice_repo.find_all_by_customer_id(customer_id)
    assert_equal 10, expected.length

    customer_id = 1000
    expected = @invoice_repo.find_all_by_customer_id(customer_id)
    assert_equal [], expected
  end

  def test_it_finds_all_by_merchant_id
    merchant_id = 12335080
    expected = @invoice_repo.find_all_by_merchant_id(merchant_id)
    assert_equal 7, expected.length

    # merchant_id_2 = 1000
    # assert_equal [], @invoice_repo.find_all_by_merchant_id(merchant_id_2).length

    assert_equal 4985, @invoice_repo.invoices.count
  end

  def test_it_finds_all_by_status
    status = :shipped
    expected = @invoice_repo.find_all_by_status(status)
    assert_equal 2839, expected.length

    status = :pending
    expected = @invoice_repo.find_all_by_status(status)
    assert_equal 1473, expected.length

    status = :sold
    expected = @invoice_repo.find_all_by_status(status)
    assert_equal [], expected
  end

  def test_it_creates_a_new_invoice_instance
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    @invoice_repo.create(attributes)
    expected = @invoice_repo.find_by_id(4986)
    assert_equal 8, expected.merchant_id
  end

  # def test_it_updates_an_invoice
  #   original_time = @invoice_repo.find_by_id(4986).updated_at
  #   attributes = {
  #         status: :success
  #   }
  #   @invoice_repo.invoices.update(4986, attributes)
  #   expected = @invoice_repo.invoices.find_by_id(4986)
  #   assert_equal :success, expected.status
  #   assert_equal 7, expected.customer_id
  #   assert expected.updated_at > original_time
  # end

  # def test_update_cannot_update_attributes
  #   attributes = {
  #     id: 5000,
  #     customer_id: 2,
  #     merchant_id: 3,
  #     created_at: Time.now
  #   }
  #   @invoice_repo.update(4986, attributes)
  #   expected = @invoice_repo.find_by_id(5000)
  #   assert_nil expected
  #
  #   expected = @invoice_repo.find_by_id(4986)
  #   assert_not_equal @invoice_repo.attributes[:customer_id], expected.customer_id
  #   assert_not_equal attributes[:merchant_id], expected.merchant_id
  #   assert_not_equal attributes[:created_at], expected.created_at
  # end

  # def test_update_on_unknown_invoice_does_nothing
  # @invoice_repo.invoices.update(5000, {})
  # end

  def test_delete_deletes_the_specified_invoice
    @invoice_repo.delete(4986)
    expected = @invoice_repo.find_by_id(4986)
    assert_nil expected
  end

  # def test_delete_on_unknown_invoice_does_nothing
  # engine.invoices.delete(5000)
  # end


end
