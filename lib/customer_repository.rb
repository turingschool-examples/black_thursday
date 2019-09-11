require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  def create(attributes)
    if attributes[:id] == nil
      attributes[:id] = find_next_id
    end
    @members.push(Customer.new(attributes))
  end

  def find_all_by_first_name(fragment)
    @members.map do | member |
      if member.first_name.downcase.include?(fragment.downcase)
        member
      end
    end.compact
  end

  def find_all_by_last_name(fragment)
    @members.map do | member |
      if member.last_name.downcase.include?(fragment.downcase)
        member
      end
    end.compact
  end
end
