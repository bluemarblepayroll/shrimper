# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'bigdecimal'
require 'forwardable'
require 'stringio'
require 'stringento'

require_relative 'proforma/attribute_based_object'
require_relative 'proforma/compiling'
require_relative 'proforma/document'
require_relative 'proforma/modeling'
require_relative 'proforma/renderers'
require_relative 'proforma/prototype'
require_relative 'proforma/template'

# The top-level API that should be seen as the main entry point into this library.
module Proforma
  class << self
    def render(
      data,
      template,
      formatter: Compiling::Formatter.new,
      renderer: Renderers::PlainTextRenderer.new,
      resolver: Compiling::Resolver.new
    )
      template.compile(data, formatter: formatter, resolver: resolver)
              .map { |prototype| renderer.render(prototype) }
    end
  end
end
