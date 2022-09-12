class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.string :username
      t.string :text
      t.integer :timeout, default: 60
      t.boolean :is_read, default: false

      t.timestamps
    end
  end
end
