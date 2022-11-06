require_relative 'merchant'
require_relative 'repository'

class MerchantRepository < Repository

  def new_obj(attributes)
    new_obj = Merchant.new(attributes)
    @repo << new_obj
    new_obj
  end

  def find_by_name(name)
    repo.find do |merchant|
      merchant.name.casecmp?(name)
    end
  end

  def find_all_by_name(name)
    repo.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end
end
