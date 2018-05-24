
class PitchforkLatest::Review
  attr_accessor :url, :album, :artist, :genre, :score, :first_paragraph, :author
  @@all = []

  def initialize
    @@all << self
  end

  def self.all
    @@all
  end

  def scrape_review_info

    doc = Nokogiri::HTML(open(self.url))

    self.score = doc.search('span.score').text
    self.first_paragraph = doc.xpath('//p').text.gsub!(/[^A-Za-z ."  ']/,'')
    self.author = doc.search('a.authors-detail__display-name').text

  end
end
