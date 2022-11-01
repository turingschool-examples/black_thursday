require_relative 'reposable'
require './lib/invoice.rb'

class InvoiceRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_customer_id
  end
  

  def find_all_by_merchant_id
  end

  def find_all_by_status
  end
end