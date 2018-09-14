require_relative './test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/sales_engine'
require_relative '../lib/repository_module'


 class InvoiceRepositoryTest < Minitest::Test

  def test_it_exists
   invoice = InvoiceRepository.new('./data/test_invoices.csv')

   assert_instance_of InvoiceRepository, invoice
  end

  def test_it_can_add_individual_items
   invoice = InvoiceRepository.new
   i = Invoice.new({
     :id          => 6,
     :customer_id => 7,
     :merchant_id => 8,
     :status      => "pending",
     :created_at  => Time.now,
     :updated_at  => Time.now,
    })
   invoice.add_individual_invoice(i)

   assert_equal [i], invoice.all
  end

  def test_it_can_return_all_invoices
   invoice = InvoiceRepository.new
   i1 = Invoice.new({
     :id          => 2,
     :customer_id => 1,
     :merchant_id => 12334753,
     :status      => "shipped",
     :created_at  => Time.now,
     :updated_at  => Time.now,
    })
    i2 = Invoice.new({
      :id          => 10,
      :customer_id => 2,
      :merchant_id => 12334839,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
     })
    invoice.add_individual_invoice(i1)
    invoice.add_individual_invoice(i2)

    assert_equal [i1, i2], invoice.all
  end

  def test_it_can_find_by_id
   invoice = InvoiceRepository.new
   i1 = Invoice.new({
     :id          => 2,
     :customer_id => 1,
     :merchant_id => 12334753,
     :status      => "shipped",
     :created_at  => Time.now,
     :updated_at  => Time.now,
    })
    i2 = Invoice.new({
      :id          => 10,
      :customer_id => 2,
      :merchant_id => 12334839,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
     })
    invoice.add_individual_invoice(i1)
    invoice.add_individual_invoice(i2)

    assert_equal i2, invoice.find_by_id(10)
    assert_equal i1, invoice.find_by_id(2)
  end

  def test_it_can_find_by_customer_id
   invoice = InvoiceRepository.new
   i1 = Invoice.new({
     :id          => 2,
     :customer_id => 1,
     :merchant_id => 12334753,
     :status      => "shipped",
     :created_at  => Time.now,
     :updated_at  => Time.now,
    })
    i2 = Invoice.new({
      :id          => 10,
      :customer_id => 2,
      :merchant_id => 12334839,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
     })

    i3 = Invoice.new({
       :id          => 13,
       :customer_id => 2,
       :merchant_id => 12334833,
       :status      => "shipped",
       :created_at  => Time.now,
       :updated_at  => Time.now,
    })
    invoice.add_individual_invoice(i1)
    assert_equal [i1], invoice.find_all_by_customer_id(1)

    invoice.add_individual_invoice(i2)
    invoice.add_individual_invoice(i3)
    assert_equal [i2, i3], invoice.find_all_by_customer_id(2)
  end

  def test_it_can_find_by_merchant_id
    invoice = InvoiceRepository.new
    i1 = Invoice.new({
      :id          => 2,
      :customer_id => 1,
      :merchant_id => 12334753,
      :status      => "shipped",
      :created_at  => Time.now,
      :updated_at  => Time.now,
     })
     i2 = Invoice.new({
       :id          => 10,
       :customer_id => 2,
       :merchant_id => 12334839,
       :status      => "pending",
       :created_at  => Time.now,
       :updated_at  => Time.now,
      })
     i3 = Invoice.new({
        :id          => 13,
        :customer_id => 2,
        :merchant_id => 12334839,
        :status      => "shipped",
        :created_at  => Time.now,
        :updated_at  => Time.now,
     })
     invoice.add_individual_invoice(i1)
     assert_equal [i1], invoice.find_all_by_merchant_id(12334753)

     invoice.add_individual_invoice(i2)
     invoice.add_individual_invoice(i3)
     assert_equal [i2, i3], invoice.find_all_by_merchant_id(12334839)
   end

   def test_it_can_create_item
     invoice = InvoiceRepository.new
     invoice.create({
       :id          => 2,
       :customer_id => 1,
       :merchant_id => 12334753,
       :status      => "shipped",
       :created_at  => Time.now,
       :updated_at  => Time.now,
      })

     assert_equal 1, invoice.all.count
   end

   def test_it_can_update_attributes
     invoice = InvoiceRepository.new
     i1 = Invoice.new({
       :id          => 2,
       :customer_id => 1,
       :merchant_id => 12334753,
       :status      => "shipped",
       :created_at  => Time.now,
       :updated_at  => Time.now,
      })
      i2 = Invoice.new({
        :id          => 10,
        :customer_id => 2,
        :merchant_id => 12334839,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
       })
     invoice.add_individual_invoice(i1)
     invoice.add_individual_invoice(i2)
     hash_1 = {
       :id          => 10,
       :customer_id => 1,
       :merchant_id => 12334763,
       :status      => "shipped",
       :created_at  => Time.now,
       :updated_at  => Time.now,
      }
     invoice.update(2, hash_1)

     assert_equal 2, i2.customer_id
     assert_equal 12334839, i2.merchant_id
   end

   def test_it_can_delete_invoices
     invoice = InvoiceRepository.new
     i1 = Invoice.new({
       :id          => 2,
       :customer_id => 1,
       :merchant_id => 12334753,
       :status      => "shipped",
       :created_at  => Time.now,
       :updated_at  => Time.now,
      })
      i2 = Invoice.new({
        :id          => 10,
        :customer_id => 2,
        :merchant_id => 12334839,
        :status      => "pending",
        :created_at  => Time.now,
        :updated_at  => Time.now,
       })
     invoice.add_individual_invoice(i1)
     invoice.add_individual_invoice(i2)
     invoice.delete(2)

     assert_nil invoice.find_by_id(2)
   end

   def test_it_can_split_csv
     invoice = InvoiceRepository.new("./data/test_invoices.csv")
    
     assert_equal 8, invoice.all.count
   end
end
