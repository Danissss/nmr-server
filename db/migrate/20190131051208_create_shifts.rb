class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
    # after generate model, it generated a migration, edit the migration file to do after-modification
    
      t.timestamps
    end
  end
end
