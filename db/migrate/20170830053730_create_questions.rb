class CreateQuestions < ActiveRecord::Migration[5.1]
  def up
    create_table :questions do |t|
      t.string "question", :null => false
      t.string "author", :null => false
      t.datetime "created_at", :null => false

      t.timestamps null: false
    end
  end
  
  def down
    drop_table :questions
  end
end
