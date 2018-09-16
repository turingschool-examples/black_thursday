require 'CSV'
require 'time'
require 'pry'
require_relative '../lib/black_thursday_helper'

class Invoice
  include BlackThursdayHelper

def initialize(params)
  @id = params[:id].to_i
  @customer_id = params[:id].to_i
  @merchant_id = params[:merchant_id].to_i
  @status = params[:status]
  @created_at = Time.parse(params[:created_at])
  @updated_at = Time.parse(params[:updated_at])
end

end
