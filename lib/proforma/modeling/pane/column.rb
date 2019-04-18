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
      # A Pane Column is a list of lines that understands how to compile itself against a
      # data source.
      class Column < AttributeBasedObject
        extend Forwardable
        include Types::Align

        attr_writer :align,
                    :label_width,
                    :lines,
                    :value_width

        def_delegator :lines, :length, :line_count

        def align
          @align || LEFT
        end

        def label_width
          @label_width ? @label_width.to_f : nil
        end

        def value_width
          @value_width ? @value_width.to_f : nil
        end

        def lines
          Array(@lines)
        end

        def compile(record, evaluator)
          compiled_lines = lines.map { |line| line.compile(record, evaluator) }

          self.class.new(
            align: align,
            label_width: label_width,
            lines: compiled_lines,
            value_width: value_width
          )
        end
      end
    end
  end
end
