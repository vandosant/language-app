require 'open-uri'

class GlosbeApi
  def self.translate_word(search)
    search_query = search.gsub(/\s/, '_')
    api_url = "http://glosbe.com/gapi/translate?from=eng&dest=por&format=json&phrase=#{search_query}"

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

    if result.any?
      word = Word.create(:english => search)

      result.each do |translation|
        Translation.create(:portuguese => translation, :word_id => word.id)
      end
    end
    result
  end

  def self.translate_phrase(search)
    search_query = search.gsub(/\s/, '_')
    api_url = "http://glosbe.com/gapi/tm?from=eng&dest=por&format=json&phrase=#{search_query}"

    response = open(api_url).read
    parsed_response = JSON.parse(response)

    examples = parsed_response['examples']

    examples.map do |example|
      {:portuguese => example['second'], :english => example['first']}
    end
  end

  def self.match_examples(words, examples)
    results = []
    local_results = []
    words.each do |word|
      examples.each do |example|
        if example[:portuguese].downcase.include?(word)
          local_results << example
        end
      end
      if local_results.length > 0
        results << {word => local_results}
        local_results = []
      else
        results << word
      end
    end
    results
  end
end