class ZdjeciesController < ApplicationController

  layout "admin"

  before_action :sprawdz_logowanie

  def index
    @zdjecia = Zdjecie.sortuj
  end

  def nowe
    @zdjecie = Zdjecie.new({:nazwa => "Wprowadź nazwę zdjęcia"})
    @licznik = Zdjecie.count + 1
    @galeria = Galerie.order('pozycja ASC')
  end

  def utworz
    @zdjecie = Zdjecie.new(zdjecie_parametry)
    if @zdjecie.save
      flash[:notice] = "Zdjęcie zostało dodane do bazy"
      redirect_to(:action => 'index')
    else
      @licznik = Zdjecie.count + 1
      @galeria = Galerie.order('pozycja ASC')
      render('nowe')
    end
  end

  def pokaz
    @zdjecie = Zdjecie.find(params[:id])
  end

  def edycja
    @zdjecie = Zdjecie.find(params[:id])
    @galeria = Galerie.order('pozycja ASC')
    @licznik = Zdjecie.count
  end

  def aktualizuj
    @zdjecie = Zdjecie.find(params[:id])
    if @zdjecie.update_attributes(zdjecie_parametry)
      flash[:notice] = "Zdjęcie zostało zaktualizowane"
      redirect_to(:action => 'pokaz', :id => @zdjecie.id)
    else
      @licznik = Zdjecie.count
      @galeria = Galerie.order('pozycja ASC')
      render('nowe')
    end
  end

  def usun
    @zdjecie = Zdjecie.find(params[:id])
  end

  def kasuj
    zdjecie = Zdjecie.find(params[:id]).destroy
    flash[:notice] = "Zdjęcie #{zdjecie.nazwa} zostało pomyślnie usunięte"
    redirect_to(:action => "index")
  end

  def zdjecie_parametry
    params.require(:zdjecie).permit(:galerie_id, :nazwa, :pozycja, :widoczne, :zdjecie, :opis, :created_at)
  end
end
