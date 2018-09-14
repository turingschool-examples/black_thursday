require 'time'
require_relative '../lib/black_thursday_helper'


class Customer
  include BlackThursdayHelper

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at
              
  def initialize(params)
    @id = params[:id].to_i
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end
end
