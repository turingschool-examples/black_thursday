require 'time'
d = "2016-01-11 09:34:06 UTC"

p Time.strptime(d, "%Y-%m-%d %H:%M:%S %Z")
