class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def sprawdz_logowanie
    unless session[:uzytkownik_id]
      flash[:notice] = "Jesteś niezalogowany"
      redirect_to(:controller => 'dostep', :action => 'login')
      return false
    else
      return true
    end
  end

end
