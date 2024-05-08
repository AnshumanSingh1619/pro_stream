class Content < ApplicationRecord
  has_many :seasons, dependent: :destroy, inverse_of: :content
  accepts_nested_attributes_for :seasons, allow_destroy: true, reject_if: :all_blank
  mount_uploader :trailer, VideoUploader
  mount_uploader :movie, VideoUploader
  mount_uploader :poster, VideoUploader

  validates_presence_of :trailer, :poster, :movie_type, :available_for_kids, :director, :description, :actor, :name
  validate :validate_movie_type

  private

  def validate_movie_type
    if movie_type == 'Movie' && seasons.present?
      errors.add(:seasons, "You cannot add seasons when creating a movie")
    elsif movie_type == 'Webseries' && seasons.blank?
      errors.add(:seasons, "Seasons must be present for a web series")
    elsif movie_type == 'Movie' && movie.blank?
      errors.add(:movie, "Movie file must be present for a movie")
    elsif movie_type == 'Webseries' && movie.present?
      errors.add(:movie, "You cannot add a movie file when creating a web series")
    end
  end
end

