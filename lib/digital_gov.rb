require 'grape'
require 'json'

require 'user_match'

module DigitalGov
	class API < Grape::API
        include UserMatch

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
            all = @@config['users'].keys()
            refs = all.reduce({}){|refhash, k| refhash[k] = "/facts/#{k}"; refhash}
            {ids: all, _links: refs}
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
            users = @@config['users']

            res = UserMatch.match(surname, dob, users)

            if res.length == 0
                status 404
                {error: "no matches found"}
            elsif res.length == 1
                status 200
                res.keys()[0]
            else
                status 404
                {error: "multiple matches found"}
            end
        end
	end
end

