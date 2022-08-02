class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.bigint :chat_id
      t.bigint :message_id
      t.string :file_id
      t.integer :duration
      t.string :recognized_text
      t.string :recognition_id, index: true
      t.bigint :response_message_id

      t.timestamps
    end
  end
end
