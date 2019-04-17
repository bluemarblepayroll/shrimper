# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    class DataTable < AttributeBasedObject
      # An explicit table column that understands how to compile header, body, and footer cells
      # from records.
      class Column < AttributeBasedObject
        include Modeling::Types::Align
        include Compiling::Compilable

        attr_writer :align,
                    :body,
                    :footer,
                    :header,
                    :width

        def align
          @align || LEFT
        end

        def body
          @body.to_s
        end

        def footer
          @footer.to_s
        end

        def header
          @header.to_s
        end

        def width
          @width ? @width.to_f : nil
        end

        def compile_header_cell(record, formatter:, resolver:)
          Modeling::Table::Cell.new(
            align: align,
            text: evaluate_text(header, record, formatter: formatter, resolver: resolver),
            width: width
          )
        end

        def compile_body_cell(record, formatter:, resolver:)
          Modeling::Table::Cell.new(
            align: align,
            text: evaluate_text(body, record, formatter: formatter, resolver: resolver),
            width: width
          )
        end

        def compile_footer_cell(record, formatter:, resolver:)
          Modeling::Table::Cell.new(
            align: align,
            text: evaluate_text(footer, record, formatter: formatter, resolver: resolver),
            width: width
          )
        end

        def footer?
          !footer.to_s.empty?
        end

        def header?
          !header.to_s.empty?
        end
      end
    end
  end
end
