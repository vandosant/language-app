require 'spec_helper'

describe Word do
  it 'saves individual words' do
    word = Word.create!(:english => 'hello')
    word_translation = Translation.create!(:portuguese => 'olá', :word_id => word.id)

    word.translations.each do |translation|
      expect(translation.portuguese).to eq 'olá'
    end
  end
end