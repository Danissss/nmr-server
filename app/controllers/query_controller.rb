class QueryController < ApplicationController


	def new
		@inputmodel = InputModel.new()
	end

	def result
		# render plain: params

		if !params[:test_sample].nil?
			x_array, y_array = RunNmrPred::draw_example_graph()
			@x_axis = x_array
			@y_axis = y_array
		end

		inputmodel = InputModel.new()
		inputmodel = params[:input_model]

		
		file_path = InputModel.new()
		if !inputmodel.nil?
			if !inputmodel[:smiles].empty?
				file_path.smiles = inputmodel[:smiles]
			end
			file_path.avatar = inputmodel[:file]   # now this works! try: render plain: file_path.avatar.current_path
		
			render plain: file_path.avatar.current_path
		end

		smiles_from_sketch = ""
		if !params[:sdf_content].nil?
			sdf_file_path = "#{Rails.root}/public/tmp_sdf/tmp.sdf"
			file = File.open(sdf_file_path, "w")
			sdf_content = params[:sdf_content]
			file.puts sdf_content

			smiles_from_sketch = MoleculeFormat::convert_sdf_to_smiles(sdf_file_path)
			while smiles_from_sketch.nil? do
				sleep(0.1)
			end
			File.delete(sdf_file_path) if File.exist?(sdf_file_path)
		end

	end
end
