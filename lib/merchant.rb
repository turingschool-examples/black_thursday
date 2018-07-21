class Merchant
  attr_reader   :id
  attr_accessor :name

  def initialize(params)
    @id   = params[:id]
    @name = params[:name]
  end

end
