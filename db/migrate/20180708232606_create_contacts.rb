class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :role
      t.string :email
      t.reference :company_id

      t.timestamps
    end
  end
end
