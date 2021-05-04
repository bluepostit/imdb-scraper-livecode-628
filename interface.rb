require 'yaml'
require_relative 'scraper'

# Scraper program

# Download the top 250 page
# Scrape: get the URLs of the top 5 films => array of URLs
# For each of the URLs:
#   Download (open) the page
#   Extract information
#   Build a hash
# end
# We have an array of 5 hashes with movie info
# Convert to YAML
# Write to file.

file_path = 'movies.yaml'

urls = fetch_movie_urls
hashes = urls.map { |url| scrape_movie(url) }

yaml = hashes.to_yaml
File.open(file_path, 'wb') do |f|
  f.write(yaml)
end
