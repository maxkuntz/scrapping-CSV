require_relative '../lib/app'


describe 'the /name/ method' do
	it 'should /action/' do
		expect(/name/(/argument/)).to eq(/result/)
	end
end
