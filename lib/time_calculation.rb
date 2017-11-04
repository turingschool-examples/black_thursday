module TimeCalculation

  def day_of_the_week(time)
    days = ["Sunday", "Monday", "Tuesday", "Wednesday",
            "Thursday", "Friday", "Saturday"]
    index = time.strftime("%w").to_i
    days[index]
  end

end
