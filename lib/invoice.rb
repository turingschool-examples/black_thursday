require 'time'
require 'csv'
require 'pry'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data, repo = nil)
    @parent      = repo
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status].to_sym
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
  end

  def merchant
    @parent.merchant_item(merchant_id)
  end

  def weekday_time
    day_num = created_at.wday
    if day_num == 0
      "Sunday"
    elsif day_num == 1
      "Monday"
    elsif day_num == 2
      "Tuesday"
    elsif day_num == 3
      "Wednesday"
    elsif day_num == 4
      "Thursday"
    elsif day_num == 5
      "Friday"
    elsif day_num == 6
      "Saturday"
    end
  end

end
