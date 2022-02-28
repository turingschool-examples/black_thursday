
module TimeHelper

  def create_time(date)
    new_date = date.split
    days_years_months = new_date[0].split("-")
    year = days_years_months[0].to_i
    month = days_years_months[1].to_i
    day = days_years_months[2].to_i
    Time.new(year, month, day)
  end

  def week_day(day)
    days = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday"}
    weekday = days[day]
    weekday
  end

end
