# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    # Emit and render basic text against a record.
    class Text < AttributeBasedObject
      include Compiling::Compilable
      extend Forwardable

      def_delegator :value, :empty?, :empty?

      attr_writer :value

      def value
        @value.to_s
      end

      def compile(data, formatter:, resolver:)
        self.class.new(
          value: evaluate_text(
            value,
            data,
            formatter: formatter,
            resolver: resolver
          )
        )
      end
    end
  end
end
