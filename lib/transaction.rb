require 'pry'
require 'time'
require_relative '../lib/black_thursday_helper'


class Transaction
  include BlackThursdayHelper

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(params)
    @id = params[:id].to_i
    @invoice_id = params[:invoice_id]
    @credit_card_number = params[:credit_card_number]
    @credit_card_expiration_date = params[:credit_card_expiration_date]
    @result = params[:result]
    @created_at = Time.parse(params[:created_at].to_s)
    @updated_at = Time.parse(params[:updated_at].to_s)
  end
end
