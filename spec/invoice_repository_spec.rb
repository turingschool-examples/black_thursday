require './spec/spec_helper'
require './lib/invoice'
require './lib/invoice_repository'

RSpec.describe InvoiceRepository do 
  let (:invoice_1) {Invoice.new({
    :id          => 6,
    :customer_id => 7,
    :merchant_id => 8,
    :status      => "pending",
    :created_at  => Time.now,
    :updated_at  => Time.now
})}

let (:invoice_2) {Invoice.new({
    :id          => 3,
    :customer_id => 5,
    :merchant_id => 6,
    :status      => "paid",
    :created_at  => Time.now,
    :updated_at  => Time.now   
    })}

let (:invoice_3) {Invoice.new({
    :id          => 4,
    :customer_id => 5,
    :merchant_id => 6,
    :status      => "paid",
    :created_at  => Time.now,
    :updated_at  => Time.now   
  })}
  describe "#initialize" do 
    it 'will exist' do 
      invoices = [invoice_1, invoice_2]
      invoice_repo = InvoiceRepository.new(invoices)

      expect(invoice_repo).to be_a(InvoiceRepository)
    end 
  end 

  describe "#all" do 
    it 'will return all invoices' do 
      invoices = [invoice_1, invoice_2]
      invoice_repo = InvoiceRepository.new(invoices)

      expect(invoice_repo.all).to eq([invoice_1, invoice_2])
    end 
  end 

  describe "find_by_id" do 
    it 'will find the invoice matching the id number' do 
      invoices = [invoice_1, invoice_2]
      invoice_repo = InvoiceRepository.new(invoices)

      expect(invoice_repo.find_by_id(6)).to eq(invoice_1)
      expect(invoice_repo.find_by_id(10)).to eq(nil)
    end 
  end 

  describe "find_all_by_customer_id" do 
    it 'will find all invoices associated with customer id' do 
      invoices = [invoice_1, invoice_2, invoice_3]
      invoice_repo = InvoiceRepository.new(invoices)

      expect(invoice_repo.find_all_by_customer_id(5)).to eq([invoice_2, invoice_3])
      expect(invoice_repo.find_all_by_customer_id(7)).to eq([invoice_1])
      expect(invoice_repo.find_all_by_customer_id(20)).to eq([])
    end 
  end 
end 
    
