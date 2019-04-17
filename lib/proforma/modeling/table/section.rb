# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  module Modeling
    class Table < AttributeBasedObject
      # A table section has zero or more rows.
      class Section < AttributeBasedObject
        attr_writer :rows

        def rows
          Array(@rows)
        end
      end
    end
  end
end
