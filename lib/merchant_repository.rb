require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def find_all_by_name(name)
    @members.map do |member|
      if member.name.downcase.include?(name.downcase)
        member
      end
    end.compact
  end

  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(Merchant.new(attributes))
  end
end
