class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(row, customer_repo)
    @id = (row[:id]).to_i
    @first_name = (row[:first_name])
    @last_name = (row[:last_name])
    @created_at = Time.parse(row[:created_at].to_s)
    @updated_at = Time.parse(row[:updated_at].to_s)
    @customer_repo = customer_repo
  end

  def update(attributes)
    update_first_name(attributes)
    update_last_name(attributes)
    update_time_stamp
  end

  def update_first_name(attributes)
    return if attributes[:first_name].nil?
    @first_name.replace(attributes[:first_name])
  end

  def update_last_name(attributes)
    return if attributes[:last_name].nil?
    @last_name.replace(attributes[:last_name])
  end

  def update_time_stamp
    @updated_at = Time.now
  end

  #items
  #spend
  #items/quanity hash
  #items/revenue hash
  
end