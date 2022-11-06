# frozen_string_literal: true

require 'time'

# This is the timeable module
module Timeable
  def convert_int_to_day(day_index)
    days = [
      'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'
    ]
    days[day_index]
  end

  def month_to_int(month)
    months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ]
    months.index(month)
  end

  def same_month?(time, month)
    convert_to_time(time).month == month
  end

  def convert_to_time(time)
    return Time.parse(time) if time.is_a? String

    time
  end
end
