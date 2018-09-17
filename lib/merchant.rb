require 'time'
class Merchant
  attr_accessor :id,
                :name

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]
  end
  
end
