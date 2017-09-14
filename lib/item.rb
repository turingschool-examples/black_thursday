require 'bigdecimal'
require 'time'

require_relative 'repository/record'


class Item < Repository::Record

  attr_reader :name, :description, :unit_price,
              :merchant_id

  def initialize(repo, fields)
    super(repo, fields)

    @id =           fields[:id].to_i
    @merchant_id =  fields[:merchant_id].to_i
    @name =         fields[:name]
    @description =  fields[:description]
    @unit_price =   (BigDecimal.new fields[:unit_price]) / 100
    @created_at =  ensure_time fields[:created_at]
    @updated_at =  ensure_time fields[:updated_at]
  end

  def merchant
    repo.parent(:merchants, merchant_id)
  end

  def ensure_time(time)
    time = Time.parse time unless time.is_a? Time
  end

end
