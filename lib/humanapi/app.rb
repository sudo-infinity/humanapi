
# THE MODULE
module HumanAPI
	# THE CLASS # TODO: Make it an instance of class HumanAPI::App :(
	class App < Nestful::Resource

		# The host of the api
		endpoint 'https://api.humanapi.co'

		# The path of the api
		path '/v1/apps'

		# This should be a private method
		def self.authentication
			Base64.encode64("#{HumanAPI.configuration.query_key}:") 
		end

		# Get the humans of your app
		def self.humans
			get("#{HumanAPI.configuration.app_id}/users", {}, {:headers => {"Authorization" => "Basic #{authentication}"}})
		end

		# Create a new human
		def self.create_human(id)
			# Make a call to create the user
			response = post("#{HumanAPI.configuration.app_id}/users", {:externalId => id}, {:headers => {"Authorization" => "Basic #{authentication}"}})

			# If the response is true
			if response.status >= 200 and response.status < 300 # Leave it for now
				JSON.parse response.body
			# Else tell me something went wrong
			else
				false # Nothing was created
			end
		end

	end
end