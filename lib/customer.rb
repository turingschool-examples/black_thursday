class Customer
  attr_reader :created_at
  attr_accessor :id,
                :updated_at,
                :first_name,
                :last_name

  def initialize(info_hash)
    @id = info_hash[:id].to_i
    @first_name = info_hash[:first_name]
    @last_name = info_hash[:last_name]
    @created_at = time_check(info_hash[:created_at])
    @updated_at = time_check(info_hash[:updated_at])
  end

  def time_check(time)
    if time.class == Time
      time
    else
      Time.parse(time)
    end
  end
end
