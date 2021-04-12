class Customer
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at
                
  def initialize(data, parent)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
    @parent = parent
  end
end