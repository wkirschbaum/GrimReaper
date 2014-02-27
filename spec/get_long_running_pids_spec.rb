require_relative 'spec_helper'

describe 'get_long_running_pids' do
  it 'gets a long running pid with one process over an hour' do
    input = "spec/one_frozen.xml"
    expected_value = [5503]
    expect(get_long_running_pids(input)).to eq(expected_value)
  end
  
  it 'gets a long running pid with two processes over an hour' do
    input = "spec/two_frozen.xml"
    expected_value = [3892, 5503]
    expect(get_long_running_pids(input)).to eq(expected_value)
  end
  
  it 'gets empty array when nothing above 1 hour' do
    input = "spec/zero_frozen.xml"
    expected_value = []
    expect(get_long_running_pids(input)).to eq(expected_value)
  end
  
end

# describe 'get_last_used_from_now' do
#   it 'converts 1393512226520122 to 6335' do
#     expect(get_last_used_from_now(1393512311127347)).to eq 6335
#   end
# end