require 'time'
require 'date'

module TimeConversions
  def to_time(time_string)
    dt = DateTime.parse(time_string)
    Time.parse(dt.to_s)
  end
end
