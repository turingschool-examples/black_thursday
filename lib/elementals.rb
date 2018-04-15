module Elementals
  def format_time(time_value)
    if time_value.class == Time
      return time_value
    else
      return Time.parse(time_value)
    end
  end
end
