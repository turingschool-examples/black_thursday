module Enumerable

  def find_by_id(id)
    @all.find {|row| row.id == id}
  end

  def find_by_name(name)
    @all.find {|row| row.name.upcase == name.upcase}
  end

  def delete(id)
    key = find_by_id(id)
    @all.delete(key)
  end

  def update(id, attributes)
    key = attributes.keys[0]
    value = attributes.values[0]
    change(id, key, value)
  end

  def change(id, key, value)
    if key == :unit_price
      find_by_id(id).unit_price = value
    elsif key == :description
      find_by_id(id).description = value
    elsif key == :name
      find_by_id(id).name = value
    else
      return nil
    end
    find_by_id(id).updated_at = Time.now
  end
end
