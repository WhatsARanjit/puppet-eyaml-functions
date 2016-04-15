require 'spec_helper'

describe 'eyaml_string' do
  it { is_expected.not_to eq(nil) }
  it { is_expected.to run.with_params().and_raise_error(ArgumentError, /wrong number of arguments/i) }
  it { is_expected.to run.with_params(1,2).and_raise_error(ArgumentError, /wrong number of arguments/i) }
end
