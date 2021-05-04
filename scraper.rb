require 'nokogiri'
require 'open-uri'

def fetch_movie_urls
  top_films_url = 'https://www.imdb.com/chart/top/?ref_=nv_mv_250'

  html = URI.open(top_films_url).read
  doc = Nokogiri::HTML(html)
  doc.search('.titleColumn a').first(5).map do |link|
    "https://www.imdb.com#{link.attributes['href'].value}"
  end
end

def scrape_movie(url)
  html = URI.open(url).read
  doc = Nokogiri::HTML(html)

  # title
  selector = '.title_wrapper h1'
  element = doc.search(selector).first
  title_string = element.text.strip
  match_data = title_string.match(/([\w\s]+)[[:space:]]\((\d+)\)/)
  title = match_data[1]
  year= match_data[2].to_i

  # director
  element = doc.search('.credit_summary_item a').first
  director = element.text.strip

  # actors
  cast = doc.search(".primary_photo + td a").take(3).map do |element|
    element.text.strip
  end

  # storyline
  storyline = doc.search(".summary_text").text.strip


  {
    title: title,
    year: year,
    director: director,
    storyline: storyline,
    cast: cast
  }
end
