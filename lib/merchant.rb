class Merchant
  attr_reader :id
  attr_accessor :name, :created_at, :updated_at

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
  end
end
