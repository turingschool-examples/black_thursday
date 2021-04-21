require 'merchant'
require_relative 'findable'

class MerchantRepo
  include Findable
  attr_reader :merchants,
              :engine

  def initialize(path, engine)
    @merchants = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data, self)
    end
  end

  def all
    @merchants
  end

  def create(attributes)
    merchant = Merchant.new(attributes, self)
    max = @merchants.max_by do |merchant|
      merchant.id
    end
    merchant.update_id(max.id)
    @merchants << merchant
    merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id, @merchants)
    return if !merchant
    merchant.update_name(attributes)
  end

  def delete(id)
    @merchants.delete(find_by_id(id, @merchants))
  end
end
