# frozen_string_literal: true

module Etl
  # Track a status
  module Status
    DEFAULT_STATES = {
      initialized: 0,
      bootstrapped: 1,
      finished: 2,
      failed: 3
    }.freeze

    def self.included(base)
      attr_reader :status

      states = base.const_defined?(:VALID_STATES) ? base.const_get(:VALID_STATES) : DEFAULT_STATES
      states.each do |verb, value|
        define_method "#{verb}?".to_sym do
          @status == value
        end

        define_method "#{verb}!".to_sym do
          @status = value
        end
      end
    end
  end
end
