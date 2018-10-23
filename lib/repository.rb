class Repository
  attr_reader :instances
  def initialize
    @instances = []
  end

  def all
    @instances
  end

  def find_by_id(id)
    @instances.find { |instance| instance.id == id }
  end

  def find_by_name(name)
    @instances.find { |instance| instance.name == name }
  end

  def find_all_by_name(name)
    @instances.find_all { |instance| instance.name == name }
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
