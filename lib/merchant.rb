class Merchant
  attr_reader :name, :id

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
  end
end
