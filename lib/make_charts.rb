require 'erb'

module MakeCharts

  def make_charts
    make_erb_template
    write_charts
  end

  def make_template_letter
    File.read "charts.erb"
  end

  def make_erb_template
    ERB.new make_template_letter
  end

  def construct_charts
    make_erb_template.result(binding)
  end

  def write_charts
    File.open("charts/charts.html", 'w') do |file|
      file.puts construct_charts
    end
  end

end