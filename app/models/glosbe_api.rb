require 'open-uri'

class GlosbeApi
  def self.translate(api_url)
    response = open(api_url).read
    parsed_response = JSON.parse(response)

    translation_data = parsed_response.select do |thing|
      thing['tuc'] if thing['tuc']
    end

    translations = translation_data['tuc'].select do |thing|
      thing['phrase'] if thing['phrase']
    end

    result = translations.map do |thing|
      thing['phrase']['text']
    end

    result
  end
end