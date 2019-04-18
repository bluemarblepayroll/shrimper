# frozen_string_literal: true

#
# Copyright (c) 2019-present, Blue Marble Payroll, LLC
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#

require 'spec_helper'

describe ::Proforma::Template do
  it '#compile should raise ArgumentError if output type is unknown' do
    template = described_class.new(output: :unknown)

    expect { template.compile(nil, nil) }.to raise_error(ArgumentError)
  end
end
