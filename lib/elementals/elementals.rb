# Elementals module for time parsing
module Elementals
  def format_time(time_value)
    time_value.class == Time ? time_value : Time.parse(time_value)
  end
end
