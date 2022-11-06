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
end
