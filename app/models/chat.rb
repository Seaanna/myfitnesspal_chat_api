class Chat < ApplicationRecord
  validates :username, :text, presence: true
  after_create :set_expiration_date

  def set_expiration_date
    self.update(expiration_date: created_at + timeout.seconds)
  end

  def as_json(options = nil)
    if options[:index]
      {
        "username": username,
        "text": text,
        "expiration_date": expiration_date,
      }
    elsif options[:username]
      {
        "id": id,
        "text": text,
      }
    elsif options[:create]
      {
        "id": id,
      }
    else
      {
        "id": id,
        "username": username,
        "text": text,
        "expiration_date": expiration_date,
        "is_read": is_read,
      }
    end
  end
end
