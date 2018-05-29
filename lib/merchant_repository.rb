require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def initialize
    super
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_all_by_name(name)
    names = @members.map do |member|
      if member.name.downcase.include?(name.downcase)
        member
      end
    end
  end

  def create(attributes)
    super
    @members.push(Merchant.new(attributes))
  end
end
