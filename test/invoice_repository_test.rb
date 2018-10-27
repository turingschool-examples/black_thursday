require_relative "./test_helper"

class InvoiceRepositoryTest < MiniTest::Test

  def setup
    @time = Time.now.to_s
    @invoice_1 = Invoice.new({
                :id          => 1,
                :customer_id => 10,
                :merchant_id => 100,
                :status      => "pending",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoice_2 = Invoice.new({
                :id          => 2,
                :customer_id => 20,
                :merchant_id => 200,
                :status      => "shipped",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoice_3 = Invoice.new({
                :id          => 3,
                :customer_id => 30,
                :merchant_id => 300,
                :status      => "returned",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoice_4 = Invoice.new({
                :id          => 4,
                :customer_id => 40,
                :merchant_id => 400,
                :status      => "returned",
                :created_at  => @time,
                :updated_at  => @time
              })
    @invoices = [@invoice_1, @invoice_2, @invoice_3, @invoice_4]
    @invoice_repo = InvoiceRepository.new(@invoices)
  end

  def test_invoice_repo_exists
    invoice = InvoiceRepository.new(@invoices)

    assert_instance_of InvoiceRepository, invoice
  end

  def test_it_can_find_by_customer_id
    expected = [@invoice_2]
    assert_equal expected, @invoice_repo.find_all_by_customer_id(20)
  end

  def test_it_can_find_all_by_merchant_id
    expected = [@invoice_1]
    assert_equal expected, @invoice_repo.find_all_by_merchant_id(100)
  end

  def test_it_can_find_all_by_status
    expected = [@invoice_3, @invoice_4]
    assert_equal expected, @invoice_repo.find_all_by_status(:returned)
  end

  def test_it_can_create_an_invoice
    invoice = @invoice_repo.create({
              :customer_id  => 50,
              :merchant_id  => 500,
              :status       => "pending"})
    assert_equal 5, invoice.id
    assert_equal :pending, invoice.status
  end

  def test_it_can_update_an_invoice
    @invoice_repo.update(1, {:status => :shipped})

    assert_equal :shipped, @invoice_1.status
  end

  def test_it_can_delete_invoice
    @invoice_repo.delete(1)
    expected = [@invoice_2, @invoice_3, @invoice_4]
    assert_equal expected, @invoice_repo.all
  end
end
