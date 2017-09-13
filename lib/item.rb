require './lib/member'

class Item < Member

  attr_reader :id, :name, :description, :unit_price,
              :created_at, :updated_at, :merchant_id

  def initialize(repo, fields)
    super(repo, fields)
    @id =           fields[:id]
    @merchant_id =  fields[:merchant_id]
    @name =         fields[:name]
    @description =  fields[:description]
    @unit_price =   fields[:unit_price]
    @created_at =   fields[:created_at]
    @updated_at =   fields[:updated_at]
  end

  def merchant
    repo.parent(:merchants, merchant_id)
  end

end
