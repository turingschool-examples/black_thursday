module Crudable
  def create_new(attributes, new_class)
    new_id = @all.max_by do |object|
      object.id
    end

    attributes[:id] = new_id.id + 1

    new_object = new_class.new(attributes)
    @all << new_object
    new_object
  end


  def delete_new(id)
    delete_object = find_by_id(id)
    @all.delete(delete_object)
  end

end
