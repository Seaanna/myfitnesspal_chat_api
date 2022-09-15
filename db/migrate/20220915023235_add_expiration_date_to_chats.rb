class AddExpirationDateToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :expiration_date, :datetime
  end
end
