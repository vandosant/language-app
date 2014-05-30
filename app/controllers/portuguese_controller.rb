require 'glosbe_api'

class PortugueseController < ApplicationController
  def index
  end

  def vocabulary
    @categories = ['basics', 'numbers']
  end

  def translate
    if params[:english]
      @english_word = params[:english]
      @word_data = GlosbeApi.translate_word("http://glosbe.com/gapi/translate?from=eng&dest=por&format=json&phrase=#{@english_word.gsub(/\s/, '_')}", @english_word)
      phrase_data = GlosbeApi.translate_phrase("http://glosbe.com/gapi/tm?from=eng&dest=por&format=json&phrase=#{@english_word.gsub(/\s/, '_')}")
      @matched_data = GlosbeApi.match_examples(@word_data, phrase_data)
      @results = false
    else
      @results = true
    end
  end

  def words
    @words = {
      :categories => ['basics', 'numbers'],
      :words => {
        :basics => [
          ["hello", "olá"],
          ["goodbye", "adeus"],
          ["good morning", "bom dia"],
          ["good afternoon", "boa tarde"],
          ["please", "faz favor"],
          ["thank you", "obrigado"],
          ["you're welcome", "de nada"]
        ],
        :numbers => [
          [1, 'um'],
          [2, 'dos'],
          [3, 'tres'],
          [4, 'quatro'],
          [5, 'cinco'],
          [6, 'seis'],
          [7, 'sete'],
          [8, 'oito'],
          [9, 'nove'],
          [10, 'dez'],
          [11, 'onze'],
          [12, 'doze'],
          [13, 'treze'],
          [14, 'catorze'],
          [15, 'quinze'],
          [16, 'dezasseis'],
          [17, 'dezassete'],
          [18, 'dezoito'],
          [19, 'dezanove'],
          [20, 'vinte'],
          [30, 'trinta'],
          [40, 'quarenta'],
          [100, 'cem'],
          [1000, 'mil']
        ]
      }
    }
    render :json => @words
  end
end