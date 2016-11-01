require './lib/merchant'

class MerchantRepository
  attr_reader  :all

  def initialize(merchant_data, parent)
    @parent = parent
    @all    = merchant_data.map { |line| Merchant.new(line).merchant }
  end

  def find_by_id(id)
    @all.find { |merchant| merchant["id"].eql?(id) }
  end 

  def find_by_name(name)
    @all.find do |merchant|
      merchant["name"].downcase.eql?(name.downcase)
    end
  end

  def find_all_by_name(fragment)
    @all.find_all do |merchant|
      merchant["name"].downcase.include?(fragment.downcase)
    end
  end

end
