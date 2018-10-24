class Repository
  attr_reader :instances
  def initialize
    @instances = []

  end

  def all
    @instances
  end

  def find_by_attribute(attribute, value)
    find_all_by_attribute(attribute, value, false)
  end

  def find_all_by_attribute(method, value, all = true)
    finder = all ? :find_all : :find
    @instances.public_send(finder) do |instance|
      instance.public_send(method) == value
    end
  end

  def find_by_id(id)
    find_by_attribute(:id, id)
  end

  def find_by_name(name)
    find_by_attribute(:name, name)
  end

  def find_all_by_name(name)
    find_all_by_attribute(:name, name)
  end

  def create(args)
    id = args[:id]
    unless id
      @count += 1
      args[:id] = @count
    else
      @count = @count < args[:id] ? args[:id] : @count
    end
    @instances << @type.public_send("new", args)
  end

  def delete(id)
    @instances.reject! { |instance| instance.id == id }
  end

  def update(id, attributes)
    found_instance = find_by_id(id)
    return nil if not found_instance
    attributes.delete(:id)
    attributes.each do |key, value|
      found_instance.public_send(key.to_s + '=', value)
    end
    found_instance.updated_at = Time.now

  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end
end
