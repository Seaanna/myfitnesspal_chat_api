class Chat < ApplicationRecord
  def expiration_date
    created_at + timeout.seconds
  end

  def as_json(options = nil)
    {
      "id": id,
      "username": username,
      "text": text,
      "expiration_date": expiration_date,
      "is_read": is_read,
    }
  end
end
