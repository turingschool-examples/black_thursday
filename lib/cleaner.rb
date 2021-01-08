require 'CSV'

class Cleaner

  def clean_id(id)
    id.to_i
  end

  def clean_name(name)
    name
  end

  def clean_date(date)
    year = date[0,4].to_i
    month = date[5,2].to_i
    day = date[8,2].to_i
    Time.new(year, month, day)
  end

end
