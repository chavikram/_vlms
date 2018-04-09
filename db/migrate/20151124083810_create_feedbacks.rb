class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :feedback_text
      t.references :contact, index: true
      t.datetime :submitted_on

      t.timestamps
    end
  end
end
