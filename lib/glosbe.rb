require 'open-uri'

class Glosbe
  def self.translate(api_url)
    response = open(api_url).read
    JSON.parse(response)
  end
end