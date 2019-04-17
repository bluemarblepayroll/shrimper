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
                    :lines

        def_delegator :lines, :length, :line_count

        def align
          @align || LEFT
        end

        def label_width
          @label_width ? @label_width.to_f : nil
        end

        def lines
          Array(@lines)
        end

        def compile(record, formatter:, resolver:)
          compiled_lines = lines.map do |line|
            line.compile(
              record,
              formatter: formatter,
              resolver: resolver
            )
          end

          self.class.new(
            align: align,
            label_width: label_width,
            lines: compiled_lines
          )
        end
      end
    end
  end
end
