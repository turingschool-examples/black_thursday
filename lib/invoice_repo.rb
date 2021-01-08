require 'CSV'
require 'time'
require 'bigdecimal'
require 'bigdecimal/util'
require './lib/module'
require './lib/invoice'

class InvoiceRepo
  include Methods
  attr_reader :collections,
              :data

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
      CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Invoice.new(data)
      end
      items
    end

    def create(attributes)
      max_id = (all.values.max_by{|item| item.id}).id.to_i
      next_id = max_id + 1
      @collections[attributes[:id]] = Invoice.new({:id => next_id.to_s,
            :name => attributes[:name].downcase,
     :description => attributes[:description].downcase,
      :unit_price => attributes[:unit_price],
     :merchant_id => attributes[:merchant_id],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]
                         }, @engine)
    end
end
