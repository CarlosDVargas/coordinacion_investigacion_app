class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.integer :articleNumber
      t.integer :certificateNumber
      t.string :researchCode

      t.timestamps
    end
  end
end
