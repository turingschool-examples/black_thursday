require 'CSV'
require 'pry'
require 'time'
require_relative '../lib/customer'
require_relative '../lib/black_thursday_helper'


class CustomerRepo
  include BlackThursdayHelper

  def initialize(filepath)
    @collections = []
    populate(filepath)
  end

  def populate(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |params|
      @collections << Customer.new(params)
    end
  end

  

end
