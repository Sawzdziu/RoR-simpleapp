class TestController < ApplicationController

  layout false
  def index
    #to jest odwolanie do pliku index.html.erb
    @testowa = "Witam w kursie Ror"
    @imiona = ["Ala", "Ewa", "Ola"]
    @id = params[:id].to_i
  end

  def test
    render('hello')
  end

  def kurs
    redirect_to('http://www.gazeta.pl')
  end
end
