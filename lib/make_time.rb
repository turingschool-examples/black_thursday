module MakeTime

  def return_time_from(object)
    return object if object.instance_of?(Time)
    return Time.parse(object) if object.instance_of?(String)
    
    nil
  end
end