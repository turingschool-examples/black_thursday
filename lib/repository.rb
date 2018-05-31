require_relative 'sales_engine'

module Repository
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |element|
      id == element.id
    end
  end

  def find_by_name(name)
    @repository.find do |element|
      name.downcase == element.name.downcase
    end
  end

  def find_all_by_name(name)
    @repository.find_all do |element|
      element.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |element|
      id == element.merchant_id
    end
  end

  def update(id, attributes)
    object = find_by_id(id)
    unless object.nil?
      object.name = attributes[:name] if attributes[:name]
      object.description = attributes[:description] if attributes[:description]
      object.unit_price = attributes[:unit_price] if attributes[:unit_price]
      object.status = attributes[:status] if attributes[:status]
      object.updated_at = Time.now unless object.class == Merchant
    end
    return nil
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
