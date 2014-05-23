require 'open-uri'

class GlosbeApi
  def self.translate_word(api_url, english_word)
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

    word = Word.create(:english => english_word)

    result.each do |translation|
      Translation.create(:portuguese => translation, :word_id => word.id)
    end
    result
  end

  def self.translate_phrase(api_url)
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