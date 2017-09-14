require './lib/member'
require 'pry'
class Item < Member

  attr_reader :id, :name, :description, :unit_price,
              :created_at, :updated_at, :merchant_id

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
    time = Time.new time unless time.is_a? Time
  end



end
