# frozen_string_literal: true

require 'time'

class Customer
  attr_reader   :id,
                :created_at
  attr_accessor :updated_at,
                :first_name,
                :last_name

  def initialize(params)
    @id          = params[:id].to_i
    @first_name  = params[:first_name].to_s
    @last_name   = params[:last_name].to_s
    @created_at  = Time.parse(params[:created_at].to_s)
    @updated_at  = Time.parse(params[:updated_at].to_s)
  end
end
