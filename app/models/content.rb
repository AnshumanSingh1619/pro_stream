class Content < ApplicationRecord
  has_many :seasons, dependent: :destroy, inverse_of: :content
  accepts_nested_attributes_for :seasons, allow_destroy: true, reject_if: :all_blank
  has_one_attached :trailer
  has_one_attached :movie
  has_one_attached :poster

  validates_presence_of :trailer, :poster, :movie_type, :available_for_kids, :director, :discription, :actor, :name
  validates_inclusion_of :available_for_kids, in: ["for 18+ only", "Available for all"]
  validates_inclusion_of :movie_type, in: ["Movie", "Webseries"]
  validate :video_format
  validate :image_format
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
