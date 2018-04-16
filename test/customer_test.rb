require 'minitest/autorun'
require 'time'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @time = "2016-01-11 09:34:06 UTC"
    @customer = Customer.new({
      :id                           => "1",
      :first_name                   => "Joey",
      :last_name                    => "Ondricka",
      :created_at                   => @time,
      :updated_at                   => @time
    })
  end

end 
