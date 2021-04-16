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

end