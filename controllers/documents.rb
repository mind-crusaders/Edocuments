# frozen_string_literal: true

require 'roda'

module Edocument
  # Web controller for Edocument API
  class Api < Roda
    route('documents') do |routing|
      @proj_route = "#{@api_root}/documents"

      routing.on String do |proj_id|
        # GET api/v1/documents/[proj_id]
        routing.get do
          account = Account.first(username: @auth_account['username'])
          document = Document.first(id: proj_id)
          policy  = DocumentPolicy.new(account, document)
          raise unless policy.can_view?

          document.full_details
                 .merge(policies: policy.summary)
                 .to_json
        rescue StandardError
          routing.halt 404, { message: 'document not found' }.to_json
        end
      end

      # GET api/v1/documents
      routing.get("add") do
        account = Account.first(username: @auth_account['username'])
        documents_scope = DocumentPolicy::AccountScope.new(account)
        viewable_documents = documents_scope.viewable

        JSON.pretty_generate(viewable_documents)
      rescue StandardError
        routing.halt 403, { message: 'Could not find documents' }.to_json
      end

      # POST api/v1/documents
      routing.post do
        new_data = JSON.parse(routing.body.read)
        new_proj = Document.new(new_data)
        raise('Could not save document') unless new_proj.save

        response.status = 201
        response['Location'] = "#{@proj_route}/#{new_proj.id}"
        { message: 'document saved', data: new_proj }.to_json
      rescue Sequel::MassAssignmentRestriction
        routing.halt 400, { message: 'Illegal Request' }.to_json
      rescue StandardError => error
        routing.halt 500, { message: error.message }.to_json
      end
    end
  end
end
