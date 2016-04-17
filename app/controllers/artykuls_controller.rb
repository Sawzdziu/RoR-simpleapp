class ArtykulsController < ApplicationController

  layout 'admin'

  before_action :sprawdz_logowanie

  def index
    @artykuly = Artykul.sortuj
  end

  def nowy
    @artykul = Artykul.new({:nazwa => "Tytuł?"})
    @strona = Strona.order('pozycja ASC')
    @licznik = Artykul.count + 1
  end

  def utworz
    @artykul = Artykul.new(artykul_parametry)
    if @artykul.save
      flash[:notice] = "Artykuł został pomyślnie utworzony"
      redirect_to(:action => 'index')
    else
      @licznik = Artykul.count + 1
      @strona = Strona.order('pozycja ASC')
      render('nowy')
    end
  end

  def edycja
    @artykul = Artykul.find(params[:id])
    @strona = Strona.order('pozycja ASC')
    @licznik = Artykul.count
  end

  def aktualizuj
    @artykul = Artykul.new(artykul_parametry)
    if @artykul.update_attributes(artykul_parametry)
      flash[:notice] = "Artykuł został pomyślnie zaktualizowany"
      redirect_to(:action => 'pokaz', :id => @artykul.id)
    else
      @licznik = Artykul.count + 1
      @strona = Strona.order('pozycja ASC')
      render('edycja')
    end
  end

  def usun
    @artykul = Artykul.find(params[:id])
  end

  def kasuj
    artykul = Artykul.find(params[:id]).destroy
    flash[:notice] = "Artykuł '#{artykul.nazwa}' został pomyślnie usunięty"
    redirect_to(:action => 'index')
  end

  def pokaz
    @artykul = Artykul.find(params[:id])
  end

  def artykul_parametry
    params.require(:artykul).permit(:nazwa, :pozycja, :widoczny, :created_at, :strona_id, :zdjecie)
  end
end
