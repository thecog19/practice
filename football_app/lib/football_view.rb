class FootballView

  def request_input
    puts "Please input the path to the file. Or leave blank for default"
    gets.strip
  end

  def output_results(results)
    results.each do |result|
      puts "#{result[2]}. #{result[0]}, #{result[1]} pts"
    end
  end

end