# frozen_string_literal: true

require 'roda'

module Edocument
  # Web controller for Edocument API
  class Api < Roda
    route('accounts') do |routing|
      @account_route = "#{@api_root}/accounts"

      routing.on 'authenticate' do
        routing.post do
          credentials = JsonRequestBody.parse_symbolize(request.body.read)
          auth_account = AuthenticateAccount.call(credentials)
          auth_account.to_json
        rescue UnauthorizedError => error
          puts [error.class, error.message].join ': '
          routing.halt '403', { message: 'Invalid credentials' }.to_json        
        #routing.route('authenticate', 'accounts')
      end
    end

      routing.on String do |username|
        # GET api/v1/accounts/[USERNAME]
        routing.get do 
          account = Account.first(username: username)
          account ? account.to_json : raise('Account not found')
        end
      end

      # POST api/v1/accounts
      routing.post do
        new_data = JSON.parse(routing.body.read)
        new_account = Account.new(new_data)
        raise('Could not save account') unless new_account.save

        response.status = 201
        response['Location'] = "#{@account_route}/#{new_account.id}"
        { message: 'Project saved', data: new_account }.to_json
      rescue Sequel::MassAssignmentRestriction
        routing.halt 400, { message: 'Illegal Request' }.to_json
      rescue StandardError => error
        puts error.inspect
        routing.halt 500, { message: error.message }.to_json
      end
    end
  end
end
