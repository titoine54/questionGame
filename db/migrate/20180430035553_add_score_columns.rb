class AddScoreColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :score, :float, :null => false, :default => 0
    add_column :questions, :ups, :integer, :null => false, :default => 0
    add_column :questions, :downs, :integer, :null => false, :default => 0
  end
end
