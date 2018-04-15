require_relative 'test_helper'
require './lib/invoice'
require './lib/invoice_repository'
require 'pry'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @invoice1 = [
      [:id, '2'],
      [:customer_id, '1'],
      [:merchant_id, '12334753'],
      [:status, 'shipped'],
      [:created_at, '2012-11-23'],
      [:updated_at, '2013-04-14']
      ]
    @invoice2 = [
      [:id, '11'],
      [:customer_id, '2'],
      [:merchant_id, '12334771'],
      [:status, 'pending'],
      [:created_at, '2008-01-07'],
      [:updated_at, '2014-05-30']
      ]
    @invoice3 = [
      [:id, '27'],
      [:customer_id, '6'],
      [:merchant_id, '12335319'],
      [:status, 'shipped'],
      [:created_at, '2011-06-21'],
      [:updated_at, '2013-07-22']
      ]
    @invoices = [@invoice1, @invoice2, @invoice3]
    @ir = InvoiceRepository.new(@invoices)
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_holds_invoices
    @ir.invoices.all? do |invoice|
      assert_instance_of Invoice, invoice
    end
    assert_instance_of Invoice, @ir.invoices[0]
    assert_instance_of Invoice, @ir.invoices[1]
  end

  def test_it_can_find_all
    @ir.all.all? do |invoice|
      assert_instance_of Invoice, invoice
    end
  end

  def test_can_find_by_id
    expected = @ir.find_by_id(2)
    assert_equal :shipped, expected.status

    expected = @ir.find_by_id(27)
    assert_equal 12335319, expected.merchant_id

    expected = @ir.find_by_id(11)
    assert_equal 2, expected.customer_id
  end

  def test_can_find_all_by_customer_id
    expected = @ir.find_all_by_customer_id(6)
    assert_equal 27, expected[0].id

    expected = @ir.find_all_by_customer_id(2)
    assert_equal 12334771, expected[0].merchant_id

    expected = @ir.find_all_by_customer_id(1)
    assert_equal :shipped, expected[0].status
  end

  def test_can_find_all_by_merchant_id
    expected = @ir.find_all_by_merchant_id(12334771)
    assert_equal 11, expected[0].id

    expected = @ir.find_all_by_merchant_id(12334753)
    assert_equal 1, expected[0].customer_id

    expected = @ir.find_all_by_merchant_id(12335319)
    assert_equal :shipped, expected[0].status
  end

  def test_can_find_all_by_status
    expected = @ir.find_all_by_status(:shipped)
    assert_equal 27, expected[1].id

    expected = @ir.find_all_by_status(:shipped)
    assert_equal 1, expected[0].customer_id

    expected = @ir.find_all_by_status(:pending)
    assert_equal 12334771, expected[0].merchant_id
  end

  # def test_it_can_update_an_invoice
  #   @se
  #   original_time = engine.invoices.find_by_id(6).status
  #   attributes = {
  #     status: "pending"
  #   }
  #   engine.invoices.update(4986, attributes)
  #   expected = engine.invoices.find_by_id(4986)
  #   expect(expected.status).to eq :success
  #   expect(expected.customer_id).to eq 7
  #   expect(expected.updated_at).to be > original_time
  # end


end
