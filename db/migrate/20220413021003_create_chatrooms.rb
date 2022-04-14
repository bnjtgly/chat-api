class CreateChatrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chatrooms do |t|
      t.string :title
      t.string :participants, array: true

      t.timestamps
    end
  end
end
