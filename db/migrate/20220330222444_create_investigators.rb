class CreateInvestigators < ActiveRecord::Migration[7.0]
  def change
    create_table :investigators do |t|
      t.string :idCard
      t.string :name
      t.string :lastname
      t.string :email

      t.timestamps
    end
  end
end
