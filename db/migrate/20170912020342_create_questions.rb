class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :question
      t.string :author
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
