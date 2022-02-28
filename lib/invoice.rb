# frozen_string_literal: false

# This class Invoice should represent a single invoice, holding an invoice id, cstomer and merchant
# id's, invoice status, and creation / updated time stamps, all of which may be referenced and some of
# which may be updated by the item_repository

# require 'simplecov'
# require 'RSpec'
# SimpleCov.start

# Represents a single invoice, to be held in a InvoiceRepository class instance
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :created_at
  attr_accessor :status, :updated_at

  def initialize(info_hash)
    @id = info_hash[:id]
    @customer_id = info_hash[:customer_id]
    @merchant_id = info_hash[:merchant_id]
    @status = info_hash[:status]
    @created_at = info_hash[:created_at]
    @updated_at = info_hash[:updated_at]
  end
end
