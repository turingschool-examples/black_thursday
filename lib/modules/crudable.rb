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

end
