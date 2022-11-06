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

  #add tests
  def create(attributes)
    attributes[:id] = max_id
    # Object.const_get() returns the class of the passed string, ie passing "Merchant" returns the Merchant Class
    # (doesn't return an instance of the Merchant Class but rather the whole Class)
    instance = Object.const_get(child_class_name).new(attributes)
    add_to_repo(instance)
  end

  # This method returns the string representation of the repository's child class name,
  # ie for the MerchantRepository class, this returns "Merchant"
  def child_class_name
    self.class.name.split('Repository').join
  end

  # add tests
  def update(id, attributes)
    instance = find_by_id(id)
    return nil if instance.nil?

    attributes.each do |key, value|
      instance.instance_variable_set("@#{key}", value)
    end
  end

  def delete(id)
    @all.delete(find_by_id(id))
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
