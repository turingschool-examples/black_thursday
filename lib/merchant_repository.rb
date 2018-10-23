require_relative 'repository'
require_relative 'merchant'
class MerchantRepository < Repository
  def initialize
    @count = 0
    super
  end

  def create(args)
    unless args[:id]
      @count += 1
      args[:id] = @count
    else
      @count = @count < args[:id] ? args[:id] : @count
    end
    super(Merchant.new(args))
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
