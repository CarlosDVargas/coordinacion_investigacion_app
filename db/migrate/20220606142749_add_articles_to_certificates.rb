class AddArticlesToCertificates < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :articles, :certificates, column: :certificateNumber
  end
end
