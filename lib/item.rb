class Item

  attr_reader :id, :name, :description, :unit_price,
              :created_at, :updated_at, :merchant_id

  def initialize(fields)
    @id =           fields[:id]
    @name =         fields[:name]
    @description =  fields[:description]
    @unit_price =   fields[:unit_price]
    @created_at =   fields[:created_at] || Time.now
    @updated_at =   fields[:updated_at] || Time.now
    @merchant_id =  fields[:merchant_id]
  end

end
