class CreateInputModels < ActiveRecord::Migration[5.2]
  def change
    create_table :input_models do |t|

      t.timestamps
    end
  end
end
