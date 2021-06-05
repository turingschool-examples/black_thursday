class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = update_time(data[:created_at])
    @updated_at = update_time(data[:updated_at])
  end

  def update_time(time)
    if time.nil?
      Time.now
    elsif time.empty?
      Time.now
    else
      Time.parse(time)
    end
  end

  def update(attributes)
    @first_name = attributes[:first_name] if !attributes[:first_name].nil?
    @last_name = attributes[:last_name] if !attributes[:last_name].nil?
    @updated_at  = update_time("")
  end

end
