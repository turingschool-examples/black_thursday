require 'CSV'
require 'time'

class Invoice

def initialize(params)
  @id = params[:id].to_i
  @customer_id = params[:id].to_i
  @merchant_id = params[:merchant_id].to_i
  @status = params[:status]
  @created_at = Time.parse(params[:created_at].to_s)
  @updated_at = Time.parse(params[:updated_at].to_s)
end

end
