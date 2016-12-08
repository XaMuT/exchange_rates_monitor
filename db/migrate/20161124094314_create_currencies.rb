class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :abbr
      t.string :cbrf_code

      t.timestamps
    end

    add_index :currencies, :abbr, unique: true
  end
end
