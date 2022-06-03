class Merchant
  attr_reader :id , :name

  def initialize(merchant)
    @id = merchant[:id].to_i
    @name = merchant[:name]


  end
  # def change(name)
  #   require "pry"; binding.pry
  #   @all.each do |value|
  #     value == value
  #   end
  # end






end
