require 'time'
class Customer

  def initialize(stats)
    @id = stats[:id].to_i
    @first_name = stats[:first_name]
    @last_name = stats[:last_name]
    @created_at = Time.parse(stats[:created_at])
    @updated_at = Time.parse(stats[:updated_at])
  end

end
