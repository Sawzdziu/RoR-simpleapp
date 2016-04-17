class Uzytkownik < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :Imie,
            :presence => {:in => true, :message => "Pole nie może być puste"}

  validates :Nazwisko,
            :presence => {:in => true, :message => "Pole nie może być puste"}

  validates :Uzytkownik,
            :length => {:within => 4..25, :message => "Nazwa użytkownika musi zawierać się pomiędzy 4 a 25 znaków"},
            :uniqueness => true

  validates :Email,
            :presence => true,
            :length => {:maximum => 100},
            :format => {:with => EMAIL_REGEX, :message => "Nie poprawny format"},
            :confirmation => true

  scope :sortuj, lambda{order("Nazwisko ASC, Imie ASC")}
end
