class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id         = attributes[:id].to_i
    @first_name = attributes[:first_name].capitalize
    @last_name  = attributes[:last_name].capitalize
    @created_at = Time.parse(attributes[:created_at].to_s)
    @updated_at = Time.parse(attributes[:updated_at].to_s)
  end

  def update_first_name(new_attributes)
    @first_name = new_attributes[:first_name].to_s
  end

  def update_last_name(new_attributes)
    @last_name = new_attributes[:last_name].to_s
  end

  def update_updated_at(new_attributes)
    @updated_at = new_attributes
  end
end
