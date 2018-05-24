
class PitchforkLatest::CLI
  attr_accessor :top_five

  def call
    greeting
    latest_scrape
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

  def latest_scrape
    @latest = PitchforkLatest::Review.scrape_latest
  end

  def show_latest
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
        the_album = @latest[input.to_i-1]
        the_album.scrape_info
        puts "'#{the_album.album}' by #{the_album.artist} -- #{the_album.genre}"
        puts "--------------------------------------------"
        puts "Score: #{the_album.score} -- Review by #{the_album.author}"
        puts "#{the_album.first_paragraph}"
        puts "                       "
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
