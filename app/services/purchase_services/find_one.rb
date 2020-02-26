module PurchaseServices
  class FindOne < ::BaseService
    ERROR_TITLE = 'Purchase Error'.freeze

    def initialize(id)
      @id = id
    end

    def call
      Purchase.find(@id)
    end
  end
end