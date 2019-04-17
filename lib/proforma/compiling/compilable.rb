# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Compiling
    # This mix-in provides common methods for model compilation.
    module Compilable
      private

      def evaluate_text(text, object, formatter:, resolver:)
        record = object.is_a?(Array) || object.nil? ? {} : object

        Stringento.evaluate(
          text,
          record,
          resolver: resolver,
          formatter: formatter
        )
      end

      def array(data)
        data.is_a?(Hash) ? [data] : Array(data)
      end
    end
  end
end
