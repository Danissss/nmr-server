class AddSdfFilePathToInputModels < ActiveRecord::Migration[5.2]
  def change
    add_column :input_models, :sdf_file_string, :string
  end
end
