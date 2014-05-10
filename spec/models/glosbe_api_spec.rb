require 'spec_helper'
require 'vcr'

describe GlosbeApi do
  it 'translates individual words' do
    VCR.use_cassette('/models/glosbe_api/translate-word') do
      translation = GlosbeApi.translate("http://glosbe.com/gapi/translate?from=eng&dest=por&format=json&phrase=hello")
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
      expect(translation).to eq expected
    end
  end
end