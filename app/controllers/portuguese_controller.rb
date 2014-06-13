require 'glosbe_api'

class PortugueseController < ApplicationController
  respond_to :js, only: :create

  def index
  end

  def vocabulary
    @categories = ['salutations', 'numbers', 'phrases']
  end

  def translate
    if params[:english]
      @search = params[:english]
      @word = Word.new

      word_data = GlosbeApi.translate_word(@search)
      phrase_data = GlosbeApi.translate_phrase(@search)

      if word_data != []
        @results = true

        if phrase_data != []
          @data = GlosbeApi.match_examples(word_data, phrase_data)
        else
          @data = word_data
        end
      else
        @results = false
      end
    else
      @search = nil
    end
  end

  def create
    @user = User.find(session[:id])
    word = Word.create(:english => params[:word][:english], :user_id => @user.id)
    @translation = Translation.new(:portuguese => params[:word][:portuguese], :word_id => word.id)

    respond_to do |format|
      if @translation.save
        format.html { redirect_to "/profile/#{@user.id}", :notice => ["word successfully added"] }
        format.js {}
        format.json { render json: @translation, status: :created, location: @translation }
      else
        format.html { render action: "translate" }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

  def words
    @words = {
      :categories => ['salutations', 'numbers', 'phrases'],
      :words => {
        :salutations => [
          ["hello", "olá"],
          ["good morning", "bom dia"],
          ["excuse me", "desculpe"],
          ["how are you?", "como está?"],
          ["good afternoon", "boa tarde"],
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
        ],
        :phrases => [
          ["please", "faz favor"],
          ["thank you", "obrigado"],
          ["you're welcome", "de nada"],
          ["where is?", "onde está?"],
          ["do you have?", "tem"],
          ["my name is", "chamo me"],
          ["what time?", "a que horas?"],
          ["very well", "muito bem"],
          ["when do you open?", "quando abrem?"],
        ]
      }
    }
    render :json => @words
  end
end