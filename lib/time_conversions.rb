require 'time'
require 'date'

class TimeConversions
  def self.to_time(time_string)
    dt = DateTime.parse(time_string)
    Time.parse(dt.to_s)
  end
end
