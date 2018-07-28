class Customer
  #will my customer name have to be attr accessor?
  attr_reader   :id,
                :first_name,
                :last_name,
                :created_at
  attr_accessor :updated_at

  def initialize(params)
    @id          = params[:id].to_i
    @first_name  = params[:first_name].to_s
    @last_name   = params[:last_name].to_s
    @created_at  = params[:created_at]
    @updated_at  = params[:updated_at]
  end
end
