class Song < ApplicationRecord
  validates :title, presence: true
  validates :artist_name, presence: true
  validates :released, inclusion: {in: [true, false]}

  validates :title, uniqueness: {scope: [:release_year, :artist_name]}

  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {less_than_or_equal_to: DateTime.now.year}
  end

  def released?
    #this will return true or false from the validation on line 4
    self.released
  end
end
