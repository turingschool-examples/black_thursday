require "time"

module TimeStoreable
  def time_store(time_data)
    if time_data.nil?
      Time.now
    elsif time_data.class == String
      Time.parse(time_data)
    else
      time_data
    end
  end
end
