# frozen_string_literal: true

module Edocument
  # Add a viwer to another owner's existing document
  class AddViewerToDocument
    def self.call(email:, document_id:)
      viewer = Account.first(email: email)
      document = Document.first(id: document_id)
      return false if document.owner.id == viewer.id
      document.add_veiwer
      document
    end
  end
end
