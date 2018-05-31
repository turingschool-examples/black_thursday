class Customer
  attr_accessor :id,
                :first_name,
                :last_name,
                :created_at,
                :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @created_at = time_conversion(attributes[:created_at])
    @updated_at = time_conversion(attributes[:updated_at])
  end

  def time_conversion(time)
    if time.class == String
      time = Time.parse(time)
    end
    time
  end
end
