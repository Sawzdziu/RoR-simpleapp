class Zdjecie < ActiveRecord::Base

  belongs_to :galerie

  has_attached_file :zdjecie,
                    :styles => { :medium => "600x600>", :thumb => "200x200>" }
  validates_attachment_content_type :zdjecie,
                                    :content_type => /^image\/(png|gif|jpeg)/,
                                    :message => '--- akcteptuje tylko pliki PNG GIF JPG ---'

  validates_attachment_size :zdjecie,
                            :in => 0..850.kilobytes,
                            :message => '--- za duży plik max rozmiar to 850 kB ---'

  validates :nazwa,
            :presence => true,
            :length => {:maximum => 120, :message => " : Za długi tytuł zdjęcia"}

  scope :widoczne, lambda{where(:widoczne => true)}
  scope :niewidoczne, lambda{where(:widoczne => false)}
  scope :sortuj, lambda{order("zdjecies.pozycja ASC")}
  scope :najnowsza, lambda{order("zdjecies.created_at DESC")}
end
