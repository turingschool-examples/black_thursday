

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
    #returns a Time instance for the
    #date the item was first created
  end

  def updated_at
    #returns a Time instance for the
    #date the itme was last modified
  end

end
