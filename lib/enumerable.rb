module Enumerable

  def find_by_id(id)
    @all.find {|row| row.id == id}
  end


  # def find_by_name(name)
  #   @all.find do |row|
  #     row.name.upcase == name.upcase
  #   end
  # end
  #
  # def delete(id)
  #   key = find_by_id(id)
  #   @all.delete(key)
  # end
  #
  # def update(id, attributes)
  #   key = attributes.keys[0]
  #   value = attributes.values[0]
  #   find_by_id(id).change(key, value)
  # end
  #
  # def change(key, value)
  #   if key == :unit_price
  #     @unit_price = value
  #   elsif key == :description
  #     @description = value
  #   elsif key == :name
  #     @name = value
  #   else
  #     return nil
  #   end
  #   @updated_at = Time.now
  # end

end
