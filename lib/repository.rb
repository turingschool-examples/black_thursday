class Repository
  attr_reader   :members

  def initialize
    @members = []
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
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
    nil
  end

  def find_by_name(name)
    @members.each do |member|
      if member.name.downcase == name.downcase
        return member
      end
    end
    nil
  end

  def delete(id)
    i = nil
    @members.each_with_index do | member, index |
      if member.id == id
        i = index
      end
    end
    if i !=nil
      @members.delete_at(i)
    end
  end

  def update(id, attributes)
    @members.each do | member |
      if member.id == id
        member.name = attributes[:name]
      end
    end
  end

  def find_next_id
    id = 0
    @members.each do | member |
      if member.id > id
        id = member.id
      end
    end
    return id + 1
  end
end
