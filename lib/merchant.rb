require 'time'
class Merchant
  attr_accessor :id,
                :created_at

  attr_accessor :name,
                :updated_at

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end

end
