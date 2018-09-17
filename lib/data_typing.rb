require 'pry'

require 'bigdecimal'
require 'time'
require 'date'


module DataTyping


  def make_integer(string)
    string.to_i
  end

  def make_symbol(string)
    string.to_sym
  end

  def make_big_decimal(string)
    string = string.chars.insert(-3, ".").join
    BigDecimal.new(string, 4)
  end

  # SPEC HARNESS
  def make_date(string)
    if string
      Date.parse(string)
    else
      Date.today
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
