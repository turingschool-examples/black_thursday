require './lib/member'

class Item < Member

  attr_reader :id, :name, :description, :unit_price,
              :created_at, :updated_at, :merchant_id

  def initialize(repo, fields)
    super(repo, fields)
    if fields[:unit_price].is_a? String
      require 'pry'; binding.pry
    end
    @id =           fields[:id].to_i
    @merchant_id =  fields[:merchant_id].to_i
    @name =         fields[:name]
    @description =  fields[:description]
    @unit_price =   Bigdecimal.new fields[:unit_price]
    @created_at =   Time.new fields[:created_at]
    @updated_at =   Time.new fields[:updated_at]
  end

  def merchant
    repo.parent(:merchants, merchant_id)
  end

end
