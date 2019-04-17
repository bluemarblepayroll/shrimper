# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

module Proforma
  # A base class that allows a pliable constructor that can set public writable attributes.
  class AttributeBasedObject
    def initialize(attrs = {})
      attrs.each do |key, value|
        method_name = "#{key}="
        send(method_name, value) if respond_to?(method_name)
      end
    end
  end
end
