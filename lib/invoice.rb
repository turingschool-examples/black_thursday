
class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, parent)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = date_convert(data[:created_at])
    @updated_at  = date_convert(data[:updated_at])
  end

  def date_convert(from_file)
    date = from_file.split("-")
    time = Time.new(date[0], date[1], date[2])
  end
  #
  # def id
  #   @information[:id].to_i
  # end
  #
  # def customer_id
  #   @information[:customer_id].to_i
  # end
  #
  # def merchant_id
  #   @information[:merchant_id].to_i
  # end
  #
  # def status
  #   @information[:status]
  # end
  #
  # def created_at
  #   date = @information[:created_at].split("-")
  #   time =Time.new(date[0],date[1],date[2])
  #   time
  # end
  #
  # def updated_at
  #   date = @information[:updated_at].split("-")
  #   time = Time.new(date[0],date[1],date[2])
  #   time
  # end

end
