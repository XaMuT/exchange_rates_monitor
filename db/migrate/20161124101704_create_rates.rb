class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.references :currency, foreign_key: true
      t.float :value
      t.string :type
      t.date :date
      t.datetime :ends_at

      t.timestamps
    end
  end
end
