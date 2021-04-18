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
    @id = id
  end

  def update_first_name(name)
    @first_name = name unless name.nil?
  end

  def update_last_name(name)
    @last_name = name unless name.nil?
  end

  def update_time
    @updated_at = Time.now
  end
end
