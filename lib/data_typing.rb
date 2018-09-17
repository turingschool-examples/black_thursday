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
      # # -- given parsed --
      # parts = string.split
      # date = parts[0] ; time = parts[1] ; zone = parts[2]
      # # -- date --
      # date = date.split("-").map { |part| part.to_i }
      # year  = date[0] ; month = date[1] ; day   = date[2]
      # # -- time --
      # time = time.split(":")
      # hour = time[0] ; min  = time[1] ; sec  = time[2]
      # # -- make time --
      # Time.utc(year, month, day, hour, min, sec)
      # # Time.utc(year, month, day, hour, min, sec_with_frac)
      Time.parse(string)
    else
      Time.now.getgm  #converts to UTC
    end
  end





end
