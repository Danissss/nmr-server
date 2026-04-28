class AddAvatarToInputModels < ActiveRecord::Migration[5.2]
  def change
    add_column :input_models, :avatar, :string
  end
end
