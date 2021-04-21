class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repo

  def initialize(customer_info, repo)
    @id = customer_info[:id].to_i
    @first_name = customer_info[:first_name].to_s
    @last_name = customer_info[:last_name].to_s
    @created_at = Time.parse(customer_info[:created_at].to_s)
    @updated_at = Time.parse(customer_info[:updated_at].to_s)
    @repo = repo
  end

  def update_all(attributes)
    update_first_name(attributes)
    update_last_name(attributes)
    update_updated_at(attributes)
  end

  def update_first_name(attributes)
    @first_name = attributes[:first_name] if attributes[:first_name]
  end

  def update_last_name(attributes)
    @last_name = attributes[:last_name] if attributes[:last_name]
  end

  def update_updated_at(attributes)
    @updated_at = attributes[:updated_at] if attributes[:updated_at]
  end

  def update_id(new_id)
    @id = new_id + 1
  end
end
