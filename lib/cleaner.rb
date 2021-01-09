require 'CSV'
require 'time'

class Cleaner

  def clean_id(id)
    id.to_i
  end

  def clean_name(name)
    name
  end

  def clean_date(date)
    if date.length == 9
      clean_date_only(date)
    else
      clean_date_time(date)
    end
  end

  def clean_date_only(date)
    year = date[0,4].to_i
    month = date[5,2].to_i
    day = date[8,2].to_i
    Time.new(year, month, day)
  end

  def clean_date_time(date)
    year = date[0,4].to_i
    month = date[5,2].to_i
    day = date[8,2].to_i
    hour = clean_date_hour(date)
    minute = clean_date_minute(date)
    second = clean_date_second(date)
    Time.new(year, month, day, hour, minute, second)
  end

  def clean_date_hour(date)
    if date[11] == 0
      hour = date[12].to_i
    else
      hour = date[11,2].to_i
    end
  end

  def clean_date_minute(date)
    if date[14] == 0
      minute = date[15].to_i
    else
      minute = date[14,2].to_i
    end
  end

  def clean_date_second(date)
    if date[17] == 0
      second = date[18].to_i
    else
      second = date[17,2].to_i
    end
  end
end
