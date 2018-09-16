require 'CSV'
require 'pry'
require 'time'
require_relative '../lib/black_thursday_helper'
require_relative '../lib/invoice_item'

class InvoiceItemRepo
  include BlackThursdayHelper

  def initialize(filepath)
    @collections = []
    populate(filepath)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << InvoiceItem.new(params)
    end
  end

end
