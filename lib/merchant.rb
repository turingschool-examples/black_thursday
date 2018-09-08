class Merchant
  attr_reader :id,
              :name

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]
  end

end
