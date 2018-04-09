class CreateFeedbackReplies < ActiveRecord::Migration
  def change
    create_table :feedback_replies do |t|
      t.references :feedback, index: true
      t.string :reply_text
      t.datetime :replied_on
      t.integer :order

      t.timestamps
    end
  end
end
