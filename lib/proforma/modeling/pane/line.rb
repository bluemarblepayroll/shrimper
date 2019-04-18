# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    class Pane < AttributeBasedObject
      # A line is a single label:value entry in a pane.
      class Line < AttributeBasedObject
        include Compiling::Compilable

        attr_writer :label, :value

        def label
          @label.to_s
        end

        def value
          @value.to_s
        end

        def compile(record, evaluator)
          self.class.new(
            label: evaluator.text(record, label),
            value: evaluator.text(record, value)
          )
        end
      end
    end
  end
end
