class Customer
  attr_reader  :id,
               :first_name,
               :last_name,
               :created_at,
               :updated_at

  def initialize(details)
    @id = details[:id]
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
end
