class Shift < ApplicationRecord


	def change
		create_table :shift do |t|
			t.string :compound_name
			t.text 	 :compound_fingerprint
			t.string :compound_shift

			t.timestamps
		end
	end

	
end
