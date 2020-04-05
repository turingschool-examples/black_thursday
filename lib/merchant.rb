class Merchant
  # attr_reader :name

  attr_accessor :id,
                :name

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]
  end

end
