

class Customer
  attr_reader   :attributes

  def initialize(data)
    modify(data)
    @attributes = data
  end

  def modify(data)
    data[:id] = data[:id].to_i
    data[:first_name] = data[:first_name]
    data[:last_name] = data[:last_name]
    data[:created_at] = Time.parse(data[:created_at])
    data[:updated_at] = Time.parse(data[:updated_at])
    data
  end

  def id
    @attributes[:id]
  end

  def first_name
    @attributes[:first_name]
  end

  def last_name
    @attributes[:last_name]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end


end
