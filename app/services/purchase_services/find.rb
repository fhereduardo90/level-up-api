module PurchaseServices
  class Find < ::BaseService
    ERROR_TITLE = 'Purchase Error'.freeze

    def call
      Purchase.all
    end
  end
end