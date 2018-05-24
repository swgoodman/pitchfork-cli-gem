class Pitchfork_Latest::CLI
  attr_accessor :top_five


  def call
    greeting
    show_latest
    menu
  end

  def greeting
    puts "                       "
    puts "----------------------------------"
    puts "Pitchfork | Music Lists"
    puts "'The most trusted voice in music.'"
    puts "----------------------------------"
    puts "                       "
    puts "Find the latest reviews from Pitchfork.com below:"
  end

  def show_latest
    @latest = Pitchfork_Latest::Review.scrape_latest
    @latest.each.with_index(1) do |review, i|
      puts "#{i}. '#{review.album}' by #{review.artist}"
    end
  end

  def menu
    input = nil
    puts "Enter the number of an album to see more info or 'exit':"
    while input != "exit"
      input = gets.strip.downcase
      if input.to_i.between?(1,@latest.length)
        puts "more info on 1."
        puts "Type 'list' to choose another or 'exit'."
      elsif input == "list"
        show_latest
        puts "Enter the number of an album to see more info or 'exit':"
      elsif input == "exit"
        goodbye
      else
        puts "Not sure what you want? Type 'list' or 'exit'."
      end
    end
  end

  def goodbye
    puts "Thanks for stopping by."
  end
end
