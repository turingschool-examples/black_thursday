require_relative '../lib/invoice_repository'
require_relative 'spec_helper'
require 'pry'

  RSpec.describe InvoiceRepository do

    before (:each) do
      se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
      @invoice = se.invoice
    end

    it 'exists' do
      expect(@invoice).to be_a(InvoiceRepository)
    end
  end
