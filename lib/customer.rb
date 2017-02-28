class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent


  def method_name(data, parent = nil)
    @id = data[:id]
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

end
