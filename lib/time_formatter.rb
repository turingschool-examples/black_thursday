module TimeFormatter
  def format_time(time_string)
    unless time_string == ""
      Time.parse(time_string)
    end
  end
end
