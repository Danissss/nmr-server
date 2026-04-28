class AddSmilesToInputModels < ActiveRecord::Migration[5.2]
  def change
    add_column :input_models, :smiles, :string
  end
end
