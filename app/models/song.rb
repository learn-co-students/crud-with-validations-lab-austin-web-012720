class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: %i[released_year artist_name],
    message: 'cannot be repeated by the same artist in the same year'
  }
  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true

  with_options if: :released? do |song|
    song.validates :released_year, presence: true
    song.validates :released_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
  end

  def released?
    released
  end

  # validate  :title_unique_per_year
  # validate  :released_year_presence_if_released

  # def title_unique_per_year
  #   if Song.all.select{ |song| song.title == title && song.released_year == released_year && song.artist_name == artist_name }.count > 0
  #     errors.add(:title, "cannot be repeated by the same artist in the same year")
  #   end
  # end
  #
  # def released_year_presence_if_released
  #   if released && released_year == nil
  #     errors.add(:released_year, "must not be blank if released is true")
  #   end
  # end


end
