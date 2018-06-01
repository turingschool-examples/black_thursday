require_relative 'repository'
require_relative 'merchant'

class MerchantRepository < Repository
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

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
    new_member = Merchant.new(attributes)
    @members.push(new_member)
    new_member
  end
end
