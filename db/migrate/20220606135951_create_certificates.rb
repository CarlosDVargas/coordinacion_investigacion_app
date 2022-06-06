class CreateCertificates < ActiveRecord::Migration[7.0]
  def change
    create_table :certificates do |t|
      t.integer :certificateNumber
      t.date :date
      #Introducir el documentoPDF luego
      
      t.timestamps
    end
  end
end
