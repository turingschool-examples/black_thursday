class Repository
  attr_reader :instances, :type
  def initialize
    @instances = []
    @count = 0
  end

  def create(args)
    unless args[:id]
      @count += 1
      args[:id] = @count
    else
      @count = @count < args[:id] ? args[:id] : @count
    end
    args[:created_at] = Time.now unless args[:created_at]
    @instances << @type.new(args)
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

  def delete(id)
    @instances.reject! { |instance| instance.id == id }
  end

  def update(id, attributes)
    found_instance = find_by_id(id)
    return nil if not found_instance

    attributes.select! do |attribute|
      @attr_whitelist.include?(attribute)
    end

    attributes.each do |key, value|
      found_instance.public_send(key.to_s + '=', value)
    end

    found_instance.updated_at = Time.now
  end

  def inspect
    "#<#{self.class} #{@instances.size} rows>"
  end
end
