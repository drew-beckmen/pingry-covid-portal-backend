class AddBarcodeToIsolations < ActiveRecord::Migration[6.0]
  def change
    add_column :isolations, :barcode, :string
  end
end
