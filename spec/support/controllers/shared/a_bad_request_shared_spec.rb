RSpec.shared_examples_for 'a bad request' do
  it 'should return an empty array' do
    subject
    expect(response_json).to be_an(Array)
  end

  it 'should return a bad request status' do
    subject
    expect(response).to be_a_bad_request
  end
end
