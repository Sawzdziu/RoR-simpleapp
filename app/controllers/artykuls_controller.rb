class ArtykulsController < ApplicationController

  layout 'admin'

  before_action :sprawdz_logowanie
  before_action :szukaj_strony

  def index
    @artykuly = @stronaID.artykuls.sortuj
  end

  def nowy
    @artykul = Artykul.new({:strona_id => @stronaID.id, :nazwa => "Tytuł?"})
    #@strona = Strona.order('pozycja ASC')
    @strona = @stronaID.kategorie.stronas.sortuj
    @licznik = Artykul.count + 1
  end

  def utworz
    @artykul = Artykul.new(artykul_parametry)
    if @artykul.save
      flash[:notice] = "Artykuł został pomyślnie utworzony"
      redirect_to(:action => 'index', :strona_id => @stronaID.id)
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
    @artykul = Artykul.find(params[:id])
    if @artykul.update_attributes(artykul_parametry)
      flash[:notice] = "Artykuł został pomyślnie zaktualizowany"
      redirect_to(:action => 'pokaz', :id => @artykul.id, :strona_id => @stronaID.id)
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
    redirect_to(:action => 'index', :strona_id => @stronaID.id)
  end

  def pokaz
    @artykul = Artykul.find(params[:id])
  end

  private
    def artykul_parametry
      params.require(:artykul).permit(:nazwa, :pozycja, :widoczny, :created_at, :strona_id, :zdjecie, :zawartosc)
    end

    def szukaj_strony
      if params[:strona_id]
        @stronaID = Strona.find(params[:strona_id])
      end
    end

end
