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
    @ir
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
    binding.pry
    @ir.all.all? do |invoice|
      assert_instance_of Invoice, invoice
    end
  end

  # def test_can_find_by_id
  #   expected = @ir.find_by_id(6)
  #   assert_equal "pending", expected.status
  #   expected = @ir.find_by_id(7)
  #   assert_equal 8, expected.merchant_id
  # end

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
