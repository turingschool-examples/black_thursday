require './lib/sales_engine'
require './lib/module'

class MerchantRepository
  include Methods
  attr_reader :data,
              :collections

  def populate_collection
    items = Hash.new{|h, k| h[k] = [] }
    CSV.foreach(@data, headers: true, header_converters: :symbol) do |data|
      items[data[:id]] = Merchant.new(data, self)
    end
    items
  end

  # def find_by_name(name)
  #   @merchant_info.find do |merchant|
  #     merchant[1].name.upcase == name.upcase
  #   end
  # end
  #
  def find_all_by_name(search_string)
    all.values.find_all do |key, value|
      value.name.upcase.include?(search_string.upcase)
    end
  end

  def max_id
    @merchant_info.max_by do |key, record|
      record.id
    end
  end

  def new_id
    max_id[0].to_i + 1
  end

  def create(new_name)
    @merchant_info[:new_id.to_s] = Merchant.new({:id => new_id.to_s, :name => new_name})
  end

  def update(id, new_name)
    @merchant_info[id] = Merchant.new({:id => id, :name => new_name})
  end

  def delete(id)
    @merchant_info.delete_if do |key, value|
      key == id
    end
  end

end
