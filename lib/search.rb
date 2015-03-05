# Search module

module Search
  def take_options_from_file_return_array(file)
    file_options = []
    File.foreach(file) { |line| file_options << line }
    file_options
  end

  def take_options_from_file_and_display(file)
    file_options = take_options_from_file_return_array(file)
    file_options.each_with_index { |option, index| puts "#{index + 1}: #{option}" }
  end
end
