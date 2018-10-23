class Repository

  def initialize
    @instances = []
  end

  def all
    @instances
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_attribute(attr_key, attr_value, all = false)
    finder = all ? :find_all : :find
    @instances.public_send(finder) do |instance|
      instance.public_send(attr_key) == attr_value
    end
  end

  def find_all_by_attribute(attr_key, attr_value)
    find_by_attribute(attr_key, attr_value, true)
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
  end

  def find_all_by_name(name)
    find_all_by_attribute(:name, name)
  end

  def create(object)
    @instances << object
  end

  def delete(id)
    @instances.reject! { |instance| instance.id == id }
  end

  def update(id, attributes)
    instance = find_by_id(id)
    attributes.each do |key, value|
      instance.public_send(key.to_s + '=', value)
    end
  end
end
