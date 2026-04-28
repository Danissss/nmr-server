# Note: This module calls Java JARs via command line
# Requirements:
#   - Java (for SDF to SMILES conversion)

module MoleculeFormat
	
	def self.included(receiver)

		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods

	end


	def self.convert_sdf_to_smiles(input)

		# input = "#{Rails.root}/public/tmp_sdf/tmp.sdf"
		smiles = `java -jar #{Rails.root}/vendor/convert_to_smiles/Convert_To_Smiles.jar #{input}`
		
		if smiles.nil? || smiles.empty?
			Rails.logger.warn "⚠️  Failed to convert SDF to SMILES. Make sure Java is installed."
			return ""
		end
		
		smiles = smiles.gsub("\n","")
		return smiles

	end


end







