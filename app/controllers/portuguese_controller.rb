require 'glosbe'

class PortugueseController < ApplicationController
  def index
  end

  def vocabulary
  end

  def translate
    if params[:english]
      @english_word = params[:english]
      @data = Glosbe.translate("http://glosbe.com/gapi/translate?from=eng&dest=por&format=json&phrase=#{@english_word.gsub(/\s/, '_')}")
    end
  end
end