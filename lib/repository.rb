class Repository
  attr_reader :all

  def initialize
    @all = []
  end

  def add_to_repo(instance)
    @all << instance
  end

  def find_by_id(id)
    @all.find do |instance|
      instance.id == id
    end
  end

  # add a superclass level test for this
  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  # add superclass level test for this 
  def max_id
    max = @all.max_by do |item|
      item.id
    end
    return 1 if max.nil?

    max.id + 1
  end

  # create and update methods to be made
  def create(attributes)
    attributes[:id] = max_id
    add_to_repo(Item.new(attributes))
  end

  # untested, un-working (so far)
  def create_helper(attributes, class_name)
    create(attributes)
    add_to_repo(class_name.new(attributes))
  end
 
  # add tests  and make work
  def update(id, attributes)
    item = find_by_id(id)
    return nil if item.nil?

    attributes.each do |key, value|
      next if [:id, :merchant_id, :created_at].include?(key)

      item.instance_variable_set("@#{key}", value)
    end
    item.updated_at = Time.now
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end
end