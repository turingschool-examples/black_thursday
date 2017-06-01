class Merchant

  attr_reader :name,
              :id

  def initialize(params = {})
    @name = params[:name]
    @id   = params[:id].to_i
  end

end
