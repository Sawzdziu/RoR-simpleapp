class Strona < ActiveRecord::Base

  belongs_to :kategorie
  has_many :artykuls

  scope :widoczna, lambda{where(:widoczna => true)}
  scope :niewidoczna, lambda{where(:widoczna => false)}
  scope :sortuj, lambda{order("stronas.pozycja ASC")}
  scope :najnowsza, lambda{order("stronas.created_at DESC")}
end
