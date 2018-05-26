class Repository

  def initialize
    @members = []
  end

  def all
    return @members
  end

  def find_by_id(id)
    @members.each do |member|
      if member.id == id
        return member
      end
    end
  end

  def find_by_name(name)
    @members.each do |member|
      if member.name == name
        return member
      end
    end
  end

  def create(attributes)
    name = attributes[:name]
    id = @members.sort_by do | member |
      member.id
    end.last + 1

    return {id: id, name: name}
  end
end
