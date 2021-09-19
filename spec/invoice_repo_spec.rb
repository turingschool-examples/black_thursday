# frozen_string_literal: true

require 'csv'
require 'simplecov'
require './lib/sales_engine'
require './lib/invoice_repo'

RSpec.describe do
  before(:each) do
    @engine = SalesEngine.from_csv({
                                     invoices: './data/invoices.csv'
                                   })
  end

  it 'exists' do
    require 'pry'
    binding.pry
    expect(@engine).to be_an_instance_of(InvoiceRepository)
  end
end
