class Merchant

  attr_reader   :id,
                :created_at
  attr_accessor :name,
                :updated_at

  def initialize(params)
    @id         = params[:id]
    @name       = params[:name]
    @created_at = params[:created_at]
    @updated_at = params[:updated_at]
  end

end
