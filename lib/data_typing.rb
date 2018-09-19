require 'pry'

require 'bigdecimal'
require 'time'
require 'date'


module DataTyping


  def make_integer(string)
    return string if string.class == Integer
    string.to_i
  end

  def make_symbol(string)
    return string if string.class == Symbol
    string.to_sym
  end

  def make_big_decimal(string)
    return string        if string.class == BigDecimal
    string = string.to_s if string.class != BigDecimal
    string = string.chars.insert(-3, ".").join
    BigDecimal.new(string, 4)
  end

  # SPEC HARNESS
  def make_date(date)
    return date if date.class == Date
    date = assess_date(date)
    date ? Date.parse(date) : Date.today
  end

  def make_time(string)
    return string if string.class == Time
    string ? Time.parse(string) : Time.now.getgm
  end

  def assess_date(date)
    if date.class == String && date.size > 10
      date = date.chars.first(10).join
    elsif date.class == Time
      date = date.to_s
      assess_date(date)
    elsif date.class == Date
      return date.to_s
    end
  end




end
