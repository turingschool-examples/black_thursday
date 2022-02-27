module Crudable

  # helper method for create
  def highest_id
    last_id = @all.map do |one|
      one.id
    end
    last_id.max
  end

  def create(attributes)
    attributes[:id] = self.highest_id + 1
    object = @new_object.new(attributes)
    @all << object
  end

  # def update(id, attributes)
  #   new_name = self.find_by_id(id)
  #   new_name.name = attributes[:name]
  #   return new_name
  # end

  def delete(id)
    erase = self.find_by_id(id)
    @all.delete(erase)
  end
end
