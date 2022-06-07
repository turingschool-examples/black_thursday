class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def update(attributes)
    # @id = attributes[:id] unless attributes[:id].nil?
    @first_name = attributes[:first_name] unless attributes[:first_name].nil?
    @last_name = attributes[:last_name] unless attributes[:last_name].nil?
    @updated_at = Time.now
  end
end
