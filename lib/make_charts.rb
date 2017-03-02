require 'erb'

module MakeCharts

  def make_charts
    template_letter = File.read "charts.erb"
    erb_template = ERB.new template_letter
    site = erb_template.result(binding)

    Dir.mkdir("sites") unless Dir.exists? "sites"
    File.open("sites/charts.html", 'w') do |file|
      file.puts site
    end
  end

end