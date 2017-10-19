class Visit < ApplicationRecord
  validates :user_id, :url_id, presence: true

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :short_url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl


  def self.record_visit!(user, shortened_url)
    Visit.new(user_id: user.id, url_id: shortened_url.id).save
  end

end
