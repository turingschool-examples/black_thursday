class Merchant
  attr_reader :id,
              :name
              
  def initialize(params)
    @id = params[:id]
    @name = params[:name]
  end

end
