class Repository
  attr_reader   :members

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
    id = nil
    if @members.length == 0
      id = 0
    else
      ids = @members.sort_by do | member |
        member.id
      end
      id = ids.last.id + 1
    end

    return {id: id, name: name}
  end

  def delete(id)
    i = nil
    @members.each_with_index do | member, index |
      if member.id == id
        i = index
      end
    end
    @members.delete_at(i)
  end

end
