require './test/test_helper.rb'
require './lib/invoice_repository.rb'
require './lib/file_loader.rb'

class InvoiceRepositoryTest < Minitest::Test
  include FileLoader

  def test_it_exists
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    assert_instance_of InvoiceRepository, invr
  end

  def test_it_makes_a_repository_of_invoices
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    assert_equal 4985, invr.repository.count
  end

  def test_all_will_return_entire_repository
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    assert_equal invr.repository, invr.all
  end

  def test_it_can_find_by_id_number
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    assert_equal invr.all[0], invr.find_by_id(1)
    assert_equal nil, invr.find_by_id(5000)
  end

  def test_it_can_find_all_by_customer_id
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    assert_equal 8, invr.find_all_by_customer_id(1).count
    assert_equal [], invr.find_all_by_customer_id('oops')
  end

  def test_it_can_find_all_by_merchant_id
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    assert_equal 16, invr.find_all_by_merchant_id(12335938).count
    assert_equal [], invr.find_all_by_merchant_id('oops')
  end

  def test_it_can_find_all_by_status
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    assert_equal 1473, invr.find_all_by_status(:pending).count
    assert_equal [], invr.find_all_by_status('oops')
  end

  def test_it_can_create_a_new_entry
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    new_invoice = invr.create(attributes)
    sorted = invr.repository.sort_by { |invoice| invoice.id }
    assert invr.repository.include?(new_invoice)
    assert_equal new_invoice, invr.find_by_id(4986)
  end

  def test_invoices_can_be_updated
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    new_invoice = invr.create(attributes)
    invr.update(4986, {status: 'shipped'})
    assert_equal invr.find_by_id(4986).status, 'shipped'
    assert_equal nil, invr.update(13000000, {status: 'shipped'})
  end

  def test_it_can_delete_an_entry
    invr = InvoiceRepository.new(load_file("./data/invoices.csv"))
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    new_invoice = invr.create(attributes)
    assert_equal 4986, new_invoice.id
    invr.delete(4986)
    assert_equal nil, invr.find_by_id(4986)
  end

end
