require 'time'
class Merchant
  attr_accessor :name,
                :updated_at,
                :id

  attr_reader  :created_at

  def initialize(params)
    @id = params[:id].to_i
    @name = params[:name]
    params[:created_at] = Time.now if params[:created_at].nil?
    params[:updated_at] = Time.now if params[:updated_at].nil?
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end
end
