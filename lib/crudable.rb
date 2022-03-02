require 'Time'
module Crudable
  # helper method for create
  def highest_id
    last_id = @all.map do |one|
      one.id
    end
    last_id.max
  end

  def create(attributes)
    attributes[:id] = highest_id + 1
    object = @new_object.new(attributes)
    @all << object
    return object
  end

  def update(id, attributes)
    attributes.each do |k, v|
      find_by_id(id).instance_variable_set(k.to_s.insert(0, '@').to_sym, v) unless update_checker(k)
    end
    if find_by_id(id).instance_variables.include?(:@updated_at)
      find_by_id(id).updated_at = Time.now
    end
  end

  def delete(id)
    erase = find_by_id(id)
    @all.delete(erase)
  end

  def update_checker (key)
    forbidden = [:id, :created_at, :merchant_id, :customer_id, :invoice_id, :item_id]
    forbidden.include?(key)
  end

end
