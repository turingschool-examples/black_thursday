require_relative 'repository'
require_relative 'merchant'


class MerchantRepository < Repository

  def record_class
    Merchant
  end

  def find_by_name(name)
    find{ |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    find_all do |merchant|
      merchant.name.downcase.include? name.downcase
    end
  end

end
