require 'rest-client'
require 'uri'


module GetSdf


	def self.included(receiver)
		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods
	end


	def self.get_sdf(input_smiles)
		input_smiles = "S(SC1=NC2=CC=CC=C2S1)C1=NC2=CC=CC=C2S1"

		# Triple bonds in SMILES strings represented by '#' have to be URL-escaped as '%23'
		input_smiles = input_smiles.gsub('#','%23')
		url = "https://cactus.nci.nih.gov/chemical/structure/#{input_smiles}/sdf"
		# url = "https://cactus.nci.nih.gov/chemicsdf"

		sdf_content = ""
		begin
			response = RestClient.get(url, headers={})
			if response.include? '$rungauss'
				sdf_content = "cactus server in maintainance"
			else
				sdf_content = response.body
			end

		rescue RestClient::ExceptionWithResponse => err
			err.response
		end
		input_smiles.gsub("/","_")



		sdf_file_path = ""
		if sdf_content.include? "maintainance"
			sdf_file_path = "maintainance"
		else

			sdf_file_path = "#{Rails.root}/public/tmp_sdf/#{input_smiles}.sdf"
			file = File.open("#{Rails.root}/public/tmp_sdf/#{input_smiles}.sdf", "w")
			file.puts sdf_content
			file.close
		end
		
		return sdf_file_path
	end


end
