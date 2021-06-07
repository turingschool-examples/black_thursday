require 'time'

module Timeable
  def update_time(time)
    if time.nil? || time.empty?
      Time.now
    else
      Time.parse(time)
    end
  end
end
