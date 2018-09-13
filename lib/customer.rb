class Customer

  attr_accessor :first_name,
                :last_name,
                :updated_at
  attr_reader   :id,
                :created_at

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @id = attributes[:id]
    @last_name = attributes[:last_name]
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end
end
