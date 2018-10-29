require 'time'

module TimeConvert

def time_converter(argument)
  if argument.class == String
    Time.parse(argument)
  else
    argument
  end
end

end
