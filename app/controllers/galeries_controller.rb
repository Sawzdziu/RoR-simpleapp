class GaleriesController < ApplicationController

  layout 'admin'

  def index
    @galerie = Galerie.sortuj
  end

  def nowa
    @galeria = Galerie.new({:nazwa => "Wprowadź nazwę"})
    @licznik = Galerie.count + 1
  end

  def utworz
    @galeria = Galerie.new(galeria_parametry)
    if @galeria.save
      flash[:notice] = "Galeria została pomyślnie utworzona"
      redirect_to(:action => "index")
    else
      @licznik = Galerie.count + 1
      render("nowa")
    end
  end

  def pokaz
    @galeria = Galerie.find(params[:id])
  end

  def edycja
    @galeria = Galerie.find(params[:id])
    @licznik = Galerie.count
  end

  def aktualizuj
    @galeria = Galerie.find(params[:id])
    if @galeria.update_attributes(galeria_parametry)
      flash[:notice] = "Galeria została pomyślnie zmodyfikowana"
      redirect_to(:action => "pokaz", :id => @galeria.id)
    else
      @licznik = Galerie.count
      render("edycja")
    end
  end

  def usun
    @galeria = Galerie.find(params[:id])
  end

  def kasuj
    galeria = Galerie.find(params[:id]).destroy
    flash[:notice] = "Galeria #{galeria.nazwa} została pomyślnie usunięta"
    redirect_to(:action => "index")
  end


  def galeria_parametry
    params.require(:galeria).permit(:nazwa, :pozycja, :widoczna, :opis, :zdjecie)
  end

end