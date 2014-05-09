require 'open-uri'

class GlosbeApi
  def self.translate(api_url)
    response = open(api_url).read
    JSON.parse(response)
  end
end