class Project < ActiveRecord::Base
  belongs_to :category

  attr_accessible :name, :description, :url, :category_id, :github_path

  validates :category_id, presence: true
  validates :name, presence: true
  validates :github_path, github_path: true

  scope :by_rating, order('rating desc')
  scope :in_review, where('is_reviewed = ?', false)
  scope :published, where('is_reviewed = ?', true)

  def update_rating
    self.rating = rating_provider.fetch
    save!
  end

  def github_url
    "https://github.com/#{github_path}" if github_path.present?
  end

  private

  def rating_provider
    @rating_provider ||= Rating::Github.new self
  end
end
