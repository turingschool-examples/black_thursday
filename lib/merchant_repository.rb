require_relative 'repository'
require_relative 'merchant'
class MerchantRepository < Repository
  def initialize
    @type = Merchant
    super
  end

  def find_all_by_name(fragment)
    @instances.select do |instance|
      instance.name.downcase.include?(fragment.downcase)
    end
  end

  def find_by_name(fragment)
    @instances.find do |instance|
      instance.name.downcase.include?(fragment.downcase)
    end
  end
end
