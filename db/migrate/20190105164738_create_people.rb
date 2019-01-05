class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :dni, null: false
      t.string :names, null: false
      t.string :surnames, null: false
      t.date :birth_date
      t.string :address
      t.string :phone
      t.string :mobile
      t.string :email

      t.timestamps
    end
  end
end
