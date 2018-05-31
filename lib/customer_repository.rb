require_relative 'customer'
require_relative 'repository'

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

  def update(id, attributes)
    member = find_by_id(id)
    if member != nil
      if attributes[:first_name] != nil
        member.first_name = attributes[:first_name]
      end
      if attributes[:last_name] != nil
        member.last_name = attributes[:last_name]
      end
      member.updated_at = Time.new
    end

  end
end
