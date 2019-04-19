# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    class Table
      # A table section has zero or more rows.
      class Section
        acts_as_hashable

        attr_writer :rows

        def initialize(rows: [])
          @rows = Row.array(rows)
        end

        def rows
          Array(@rows)
        end
      end
    end
  end
end
