# frozen_string_literal: true

require 'roda'

module Edocument
  # Web controller for Edocument API
  class Api < Roda
    route('accounts') do |routing|
      @account_route = "#{@api_root}/accounts"

      routing.on String do 
        # GET api/v1/accounts/[USERNAME]
        routing.get do |username|
          account = Account.first(username: username)
          account ? account.to_json : raise('Account not found')
        end
      end

      # POST api/v1/accounts
      routing.post do
        new_data = JSON.parse(routing.body.read)
        new_account = EmailAccount.new(new_data)
        raise('Could not save account') unless new_account.save

        response.status = 201
        response['Location'] = "#{@account_route}/#{new_account.id}"
        { message: 'Project saved', data: new_account }.to_json
      end
    end
  end
end
