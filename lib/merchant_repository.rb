require './lib/repository'

class MerchantRepository < Repository
  def initialize
    super
  end

  def find_all_by_name(name)

    names = @members.map do |member|
      if member.name.downcase.include?(name.downcase)
        member
      end
    end
  end

  def create(attributes)
    base_attributes = super
    @members.push(Merchant.new(base_attributes))
  end
end
