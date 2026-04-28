class InputModel < ApplicationRecord

	

	def change
		create_table :input_model do |t|
			t.string :smiles
			t.string :sdf_file_string
			

			t.timestamps
		end
	end
end
