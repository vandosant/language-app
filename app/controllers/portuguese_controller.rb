require 'glosbe_api'

class PortugueseController < ApplicationController
  def index
  end

  def vocabulary
    @words = [
      ["hello", "olá"],
      ["goodbye", "adeus"],
      ["please", "por favor"],
      ["thank you", "obrigado"],
      ["you're welcome", "de nada"]
    ]
  end

  def translate
    if params[:english]
      @english_word = params[:english]
      @word_data = GlosbeApi.translate_word("http://glosbe.com/gapi/translate?from=eng&dest=por&format=json&phrase=#{@english_word.gsub(/\s/, '_')}")
      phrase_data = GlosbeApi.translate_phrase("http://glosbe.com/gapi/tm?from=eng&dest=por&format=json&phrase=#{@english_word.gsub(/\s/, '_')}")
      @matched_data = GlosbeApi.match_examples(@word_data, phrase_data)
      @results = false
    else
      @results = true
    end
  end

  def words
    @words = [
      ["hello", "olá"],
      ["goodbye", "adeus"],
      ["please", "por favor"],
      ["thank you", "obrigado"],
      ["you're welcome", "de nada"]
    ]
    render :json => @words
  end
end