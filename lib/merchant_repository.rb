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

  def create(attributes)
      @collections[attributes[:id.to_s]] =
      Merchant.new({:id => new_id.to_s,
              :name => attributes[:name].downcase,
        :created_at => attributes[:created_at],
        :updated_at => attributes[:updated_at]}, @engine)
  end

  def delete(id)
    @merchant_info.delete_if do |key, value|
      key == id
    end
  end

end
