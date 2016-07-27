require 'bigdecimal'

class Item
  attr_reader :name,
              :id,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :repo


  def initialize(item_details, repo = nil)
    @id          = item_details[:id].to_i
    @name        = item_details[:name]
    @description = item_details[:description]
    @unit_price  = BigDecimal.new(item_details[:unit_price].to_f, 4)
    @merchant_id = item_details[:merchant_id]
    @created_at  = format_time(item_details[:created_at].to_s)
    @updated_at  = format_time(item_details[:updated_at].to_s)
    @parent      = repo
  end

  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end

  def merchant
    @parent.find_merchant_by_merchant_id(self.merchant_id)
  end
end
