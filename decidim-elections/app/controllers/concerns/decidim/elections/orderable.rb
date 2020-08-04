# frozen_string_literal: true

require "active_support/concern"

module Decidim
  module Elections
    # Common logic to sorting resources
    module Orderable
      extend ActiveSupport::Concern

      included do
        include Decidim::Orderable

        private

        # Available orders based on enabled settings
        def available_orders
          @available_orders ||= begin
            available_orders = %w(recent older)
            available_orders
          end
        end

        def default_order
          "recent"
        end

        def reorder(elections)
          case order
          when "recent"
            elections.order(start_time: :asc)
          else
            elections.order(start_time: :desc)
          end
        end
      end
    end
  end
end
