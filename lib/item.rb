

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
    @unit_price  = item_details[:unit_price]
    @merchant_id = item_details[:merchant_id]
    # @created_at  = item_details[:created_at]
    @created_at  = format_time(item_details[:created_at].to_s)
    @updated_at  = format_time(item_details[:updated_at].to_s)
    @repo        = repo
  end

  def format_time(time_string)
    unless time_string == ""
      DateTime.strptime(time_string, '%Y-%m-%d %H:%M:%S %z')
    end
  end
end
