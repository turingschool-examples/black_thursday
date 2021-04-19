class Customer
  attr_reader  :id,
               :first_name,
               :last_name

  def initialize(details)
    @id = details[:id].to_i
    @first_name = details[:first_name]
    @last_name = details[:last_name]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

  def update_id(id)
    return false if id.nil?

    @id = id
  end

  def update_first_name(name)
    return false if name.nil?

    @first_name = name
  end

  def update_last_name(name)
    return false if name.nil?

    @last_name = name
  end

  def update_time
    @updated_at = Time.now
  end

  def created_at
    return @created_at if @created_at.instance_of?(Time)

    Time.parse(@created_at)
  end

  def updated_at
    return @updated_at if @updated_at.instance_of?(Time)

    Time.parse(@updated_at)
  end
end
