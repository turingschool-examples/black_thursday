require 'CSV'
require 'time'
require './lib/module'
require './lib/customer'

class CustomerRepo
  include Methods
  attr_reader :collections

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
      CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Customer.new(data, self)
      end
      items
    end

    def find_all_by_first_name(first_name)
      all.values.find_all do |value|
        value.first_name == first_name
      end
    end

    def find_all_by_last_name(last_name)
      all.values.find_all do |value|
        value.last_name == last_name
      end
    end


    def create(attributes)
      @collections[attributes[:id]] = Customer.new({:id => new_id,
      :first_name => attributes[:first_name],
      :last_name=> attributes[:last_name],
      :created_at => attributes[:created_at],
      :updated_at => attributes[:updated_at]},self)
    end
end
