
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
    puts "--------------------------------------------------"
    puts "Pitchfork.com | 'The most trusted voice in music.'"
    puts "--------------------------------------------------"
    puts "                       "
    puts "Find the latest reviews from Pitchfork.com below:"
    puts "                       "
  end

  def latest_scrape
    @latest = PitchforkLatest::Scraper.new.scrape_latest
  end

  def show_latest
    rows = []
    @latest.each.with_index(1) do |review, i|
      rows << ["#{i}.","'#{review.album}' by #{review.artist}" ]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end

  def menu

    puts "                       "
    puts "Enter the number of an album to see more info or 'exit':"
    input = nil

    while input != "exit"
      input = gets.strip.downcase

      if input.to_i.between?(1,@latest.length)
        the_album = @latest[input.to_i-1]
        the_album.scrape_review_info
        puts "                       "
        puts "--------------------------------------------"
        puts "'#{the_album.album}' by #{the_album.artist}"
        puts "Genre: #{the_album.genre}"
        puts "--------------------------------------------"
        puts "                       "
        puts "Score: #{the_album.score}"
        puts "                       "
        puts "Review by #{the_album.author}"
        puts "                       "
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
    puts "                       "
    puts "-----------------------"
    puts "Thanks for stopping by."
    puts "-----------------------"
    puts "                       "
  end
end
