require 'glosbe_api'

class PortugueseController < ApplicationController
  def index
  end

  def vocabulary
    @categories = ['basics', 'numbers']
  end

  def translate
      @word = Word.new

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

  def create
    @user = User.find(session[:id])
    word = Word.create!(:english => params[:word][:english], :user_id => @user.id)
    Translation.create!(:portuguese => params[:word][:portuguese], :word_id => word.id)
    redirect_to "/profile/#{@user.id}", :notice => ["word successfully added"]
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