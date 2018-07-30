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

  def create(attributes)  #will self work here?
    new_element = self.new(attributes)
    max_element_id = all.max_by do |element|
      element.id
    end
    new_element.id = max_element_id + 1
    all << new_element
    new_element
  end

  def update(id, attributes)
    element_to_change = find_by_id(id)
    return if element_to_change.nil?
    if attributes[:name]
      element_to_change.name = attributes[:name]
    end
    if attributes[:description]
      element_to_change.description = attributes[:description]
    end
    if attributes[:unit_price]
      element_to_change.unit_price = attributes[:unit_price].to_f * 100
    end
    element_to_change.updated_at = Time.now
    return element_to_change
  end

  def delete(id)
    element_to_delete = find_by_id(id)
    all.delete(element_to_delete)
  end


end



Collapse 