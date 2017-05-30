class Item

  attr_reader :name, :description, :unit_price, :created_at, :updated_at

  # def initialize({name => ""
  #                 description => "",
  #                 unit_price => "" ,
  #                 created_at => "" ,
  #                 updated_at => "" })

  def initialize(name, description, unit_price, created_at, updated_at)
    @name = name
    @description = description
    @unit_price = unit_price
    @created_at = created_at
    @updated_at = updated_at

  end

end
