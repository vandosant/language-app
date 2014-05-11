require 'spec_helper'
require 'vcr'

describe GlosbeApi do

  let(:word_translation) do
    GlosbeApi.translate_word("http://glosbe.com/gapi/translate?from=eng&dest=por&format=json&phrase=hello")
  end

  it 'translates individual words' do
    VCR.use_cassette('/models/glosbe_api/translate-word') do
      expected = [
        'olá',
        'oi',
        'alô',
        'bom dia',
        'acorda',
        'e aí',
        'boa tarde',
        'bom día'
      ]
      expect(word_translation).to eq expected
    end
  end

  let(:phrase_translation) do
    GlosbeApi.translate_phrase("http://glosbe.com/gapi/tm?from=eng&dest=por&format=json&phrase=hello")
  end

  it 'finds examples of words used in phrases' do
    VCR.use_cassette('/models/glosbe_api/find-examples') do
      expect(phrase_translation).to include({:portuguese => "Oh, olá outra vez", :english => "Oh, hello again"})
    end

    VCR.use_cassette('/models/glosbe_api/match-examples') do
      matched_translations = GlosbeApi.match_examples(word_translation, phrase_translation)
      expect(matched_translations).to include({"bom dia"=>[{:portuguese=>"Bom dia, Amêlie- mêlo!", :english=>"Hello, Amélie- mellow!"}]})
    end
  end
end