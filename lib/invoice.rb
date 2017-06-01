

class Invoice

  attr_reader :information,
              :parent

  def initialize(information, parent)
    @information = information
    @parent = parent
  end

  def id
    @information[:id].to_i
  end

  def customer_id
    @information[:customer_id].to_i
  end

  def merchant_id
    @information[:merchant_id].to_i
  end

  def status
    @information[:status]
  end

  def created_at
    date = @information[:created_at].split("-")
    time =Time.new(date[0],date[1],date[2])
    time
  end

  def updated_at
    date = @information[:updated_at].split("-")
    time = Time.new(date[0],date[1],date[2])
    time
  end

end
