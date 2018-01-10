module Calculator

  DAYS = {
    0 => "Sunday",
    1 => "Monday",
    2 => "Tuesday",
    3 => "Wednesday",
    4 => "Thursday",
    5 => "Friday",
    6 => "Saturday"
  }

  MONTHS = {
    "january" => "01",
    "february" => "02",
    "march" => "03",
    "april" => "04",
    "may" => "05",
    "june" => "06",
    "july" => "07",
    "august" => "08",
    "september" => "09",
    "october" => "10",
    "november" => "11",
    "december" => "12"
  }

  def average(sum, length)
    (sum / length.to_f)
  end

  def sqrt(num)
    num ** (0.5)
  end
end
