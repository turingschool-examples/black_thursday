class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent
  def initialize(info, parent = nil)
    @id = info[:id]
    @first_name = info[:first_name]
    @last_name = info[:last_name]
    @created_at = Time.parse(info[:created_at])
    @updated_at = Time.parse(info[:updated_at])
    @parent = parent
  end
end
