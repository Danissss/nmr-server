# Note: This module calls Java JARs via command line
# Requirements:
#   - Java (for JAR execution)
#   - Python 3 (for MATLAB integration)
#   - MATLAB with MATLAB Engine for Python 3
#     Install: cd /Applications/MATLAB_R20XX.app/extern/engines/python && python3 setup.py install

module RunNmrPred
	
	def self.included(receiver)

		receiver.extend         ClassMethods
		receiver.send :include, InstanceMethods

	end


	def self.run(input)

		value = `java -jar #{Rails.root}/vendor/nmr_pred/nmr_pred.jar #{input}`
		if value.nil? || value.empty?
			Rails.logger.warn "⚠️  Java JAR failed. Make sure Java is installed."
			return [], []
		end
		
		output = `python3 #{Rails.root}/vendor/callMatlab.py #{value}`
		if output.nil? || output.empty?
			Rails.logger.warn "⚠️  Python script failed. Make sure Python 3 and MATLAB Engine are installed."
			return [], []
		end
		
		x_array,y_array = RunNmrPred::prepare_data(output)
		return x_array,y_array

	end

	
	def self.run_example()

		file_path = "#{Rails.root}/public/HMDB00001.sdf"
		value = `java -jar #{Rails.root}/vendor/nmr_pred/nmr_pred.jar #{file_path}`
		
		return value
	end

	
	def self.draw_graph(shift)

		output = `python3 #{Rails.root}/vendor/callMatlab.py #{shift}`
		if output.nil? || output.empty?
			Rails.logger.warn "⚠️  Python/MATLAB script failed. Make sure Python 3 and MATLAB Engine are installed."
			return ""
		end

		return output
		
	end

	# x_array,y_array return the array of value on x axis and y axis
	def self.draw_example_graph()

		shift = "3.07;3.16;3.68;3.96;7.0;7.67"
		output = `python3 #{Rails.root}/vendor/callMatlab.py #{shift}`
		
		if output.nil? || output.empty?
			Rails.logger.warn "⚠️  Python/MATLAB script failed. Install Python 3 and MATLAB Engine for Python."
			Rails.logger.warn "⚠️  Run: cd /Applications/MATLAB_R20XX.app/extern/engines/python && python3 setup.py install"
			return [], []
		end
		
		x_array,y_array = RunNmrPred::prepare_data(output)
		return x_array,y_array
		
	end


	def self.prepare_data(input)

		if input.nil? || input.empty?
			Rails.logger.warn "⚠️  No data to prepare"
			return [], []
		end
		
		output_list = input.split("matlab.double")
		
		if output_list.length < 3
			Rails.logger.warn "⚠️  Invalid output format from Python/MATLAB script"
			return [], []
		end

		x = output_list[1]
		y = output_list[2]

		x = x.gsub("[","")
		x = x.gsub("]","")
		x = x.gsub("(","")
		x = x.gsub(")","")
		x = x.gsub(" ","")

		y = y.gsub("]","")
		y = y.gsub("[","")
		y = y.gsub("(","")
		y = y.gsub(")","")
		y = y.gsub("\n","")
		y = y.gsub(" ","")

		x_string_array = x.split(",")
		y_string_array = y.split(",")

		x_array = []
		for x in 0 ... x_string_array.length
			x_array[x] = x_string_array[x].to_f
		end

		y_array = []
		for y in 0 ... y_string_array.length
			y_array[y] = y_string_array[y].to_f
		end

		return x_array,y_array

	end



	def self.loadsample()

		x_array = [1,2,3,4,5,6,7,8,9]
		y_array = [2,3,4,5,6,7,8,9,10]
		return x_array, y_array

	end

end







