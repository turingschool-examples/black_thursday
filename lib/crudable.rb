module Crudable

  # helper method for create
  def highest_id
    last_id = 0
    @all.max do |one|
      last_id = one.id
    end
    return last_id
  end

  def create(attributes)
    attributes[:name] = @new_object.new({ :id => self.highest_id + 1, :name => attributes[:name] })
  end

  def update(id, attributes)
    new_name = self.find_by_id(id)
    new_name.name = attributes[:name]
    return new_name
  end

  def delete(id)
    erase = self.find_by_id(id)
    @all.delete(erase)
  end
end
