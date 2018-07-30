require 'time'

module Repository

  def find_by_id(id)
    all.find do |element|
      element.id == id
    end
  end

  def find_by_name(name)
    all.find do |element|
      element.name.downcase == name.downcase
    end
  end

  def delete(id)
    element_to_delete = find_by_id(id)
    all.delete(element_to_delete)
  end


end



Collapse 