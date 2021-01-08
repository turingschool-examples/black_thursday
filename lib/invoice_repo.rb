require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/module'
require './lib/invoice'

class InvoiceRepo
  include Methods
  attr_reader :collections

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
      CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Invoice.new(data, self)
      end
      items
    end

    def create(attributes)
      max_id = (all.values.max_by{|item| item.id}).id.to_i
      next_id = max_id + 1
      @collections[attributes[:id]] = Invoice.new({:id => next_id.to_s,
      :customer_id => attributes[:customer_id],
      :merchant_id => attributes[:merchant_id],
      :status => attributes[:status],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]}, self)
    end
end
