require 'grape'
require 'json'

module DigitalGov
	class API < Grape::API
        @@config = {}

        def self.conf_file=(value)
            path = File.absolute_path(
                File.join(
                    File.split(__FILE__)[0], 
                    "..", 
                    "config", 
                    value
                )
            )
            @@config = JSON.load(File.read path)
        end

		format :json

        desc 'Returns the ids that we have'
        get '/facts' do
            @@config['users'].keys()
        end

        desc 'given an id, return user details'
        get '/facts/:id' do
            id = params[:id]
            if @@config['users'].has_key?(id)
                data = @@config['users'][id]
                status data['status']
                data['data']
            else
                status 404
                {'message' => "User for #{id} not found"}
            end
        end

        desc 'Return a personal timeline. Requires at least surname and dob (YYYY-MM-DD format) query params'
        get '/identify' do
            surname = params[:surname]
            dob = params[:dob]

            puts "ZZZ: #{surname} : #{dob}"
            status 404
            {error: "multiple matches found"}
        end
	end
end

