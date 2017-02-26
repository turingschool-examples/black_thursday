class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repo

  def initialize(info, customer_repo = '')
    @id = info[:id].to_i
    @first_name = info[:first_name]
    @last_name = info[:last_name]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @customer_repo = customer_repo
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end
  

end
