class Customer
  attr_reader :id,
              :created_at

  attr_accessor :first_name,
                :last_name,
                :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @first_name = data[:first_name]
    @last_name = data[:last_name]
    @created_at = data[:created_at].to_s
    @updated_at = data[:updated_at].to_s
  end

  def created_at
    if @created_at != nil
      Time.parse(@created_at)
    end
  end

  def updated_at
    if @updated_at != nil
      Time.parse(@updated_at)
    end
  end
end
