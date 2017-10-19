class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :submitter, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User


  def self.random_code
    code = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64
    end
    code
  end

  def self.create!(user, long_url)
    code = ShortenedUrl.random_code
    ShortenedUrl.new(long_url: long_url, short_url: code, user_id: user.id).save
  end

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor

  def num_clicks
    self.visits.count
  end

  def num_uniques
    # self.visits.select(:user_id).distinct.count
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.select(:user_id).distinct
        .where({ created_at: (Time.now - 60.minute)..Time.now })
        .count
  end

end
