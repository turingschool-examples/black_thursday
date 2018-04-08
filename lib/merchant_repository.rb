require 'csv'
require_relative 'merchant'

class MerchantRepository

  attr_reader :path,
              :merchants

  def initialize(path)
    @merchants = []
    @path = path
    load_path(path)
  end

  def all
    @merchants
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @merchants << Merchant.new(data)
    end
  end

  def find_by_id(id)
    @merchants.find do |merchant|
      merchant.id == id.to_i
    end
  end

  def find_by_name(name)
    @merchants.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create_new_id
    @merchants.map do |merchant|
      merchant.id
    end.max + 1
  end

  def create(attribute)
    attribute[:id] = create_new_id
    attribute[:created_at] = Time.now.strftime("%F")
    attribute[:updated_at] = Time.now.strftime("%F")
    @merchants << Merchant.new(attribute)
  end

  def update(id, attribute)
    find_by_id(id).updated_at = Time.now.strftime("%F")
    find_by_id(id).name = attribute[:name]

  end

  def delete(id)
    @merchants.delete(find_by_id(id))
  end

  def inspect
   "#<#{self.class} #{@merchants.size} rows>"
 end

end
