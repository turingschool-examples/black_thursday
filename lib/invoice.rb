class Invoice
  attr_accessor :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :created_day

  attr_reader :repo

  def initialize(data, repo)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    created_day
  end

  def update(attributes)
    if attributes.keys.include?(:status)
      @status        = attributes[:status] if attributes[:status]
      @updated_at  = Time.now
    end
  end

  def created_day
    weekdays = {0 => :sunday,
                1 => :monday,
                2 => :tuesday,
                3 => :wednesday,
                4 => :thursday,
                5 => :friday,
                6 => :saturday,
              }
    weekdays[@created_at.wday]
  end
end
