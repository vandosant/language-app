class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :portuguese
      t.integer :word_id
      t.index :word_id
      t.timestamps
    end
  end
end
