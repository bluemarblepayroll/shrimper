# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    # A general purpose grouping of modeling objects.  When compiled, they will each be
    # compiled once then their output(s) are combined and flattened.
    class Collection < AttributeBasedObject
      attr_writer :children

      def children
        Array(@children)
      end

      def compile(data, formatter:, resolver:)
        children.map do |section|
          if section.respond_to?(:compile)
            section.compile(
              data,
              formatter: formatter,
              resolver: resolver
            )
          else
            section
          end
        end.flatten
      end
    end
  end
end
