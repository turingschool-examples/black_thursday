require 'pry'

require 'bigdecimal'
require 'time'


module DataTyping


  def make_integer(string)
    string.to_i
  end

  def make_big_decimal(string)
    BigDecimal.new(string, 4)
  end

  def make_date(string)
    if string
      # date
    else
      # new date
    end
  end

  def make_time(string)
    if string
      Time.parse(string)
    else
      Time.now.getgm  #converts to UTC
    end
  end





end
