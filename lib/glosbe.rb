require 'open-uri'

class Glosbe
  def self.translate(api_url)
    response = open(api_url).read
    puts JSON.parse(response)
  end
end