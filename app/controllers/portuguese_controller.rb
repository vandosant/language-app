require 'glosbe_api'

class PortugueseController < ApplicationController
  def index
  end

  def vocabulary
  end

  def translate
    if params[:english]
      @english_word = params[:english]
      @data = GlosbeApi.translate("http://glosbe.com/gapi/translate?from=eng&dest=por&format=json&phrase=#{@english_word.gsub(/\s/, '_')}")
      @results = false
    else
      @results = true
    end
  end
end