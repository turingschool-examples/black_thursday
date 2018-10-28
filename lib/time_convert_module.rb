require 'time'

module TimeConvert

def time_converter(arguement)
  if arguement.class == String
    Time.parse(arguement)
  else
    arguement
  end
end

end
