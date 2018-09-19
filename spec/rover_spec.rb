require 'rover'

RSpec.describe Rover do
  it 'accepts an initial state' do
    rover = Rover.new(1,2,'N')

    expect(rover.x).to eq(1)
    expect(rover.y).to eq(2)
    expect(rover.bearing).to eq('N')
  end

  context 'when initial bearing is invalid' do
    it 'raises an error' do
      expect { Rover.new(0, 0, 'Q') }.to raise_error(ArgumentError)
    end
  end

  describe '#rotate_left' do
    subject { Rover.new(0,0, initial_bearing) }

    before { subject.rotate_left }

    context 'when facing North' do
      let(:initial_bearing) { 'N' }

      it 'rotates to face West' do
        expect(subject.bearing).to eq('W')
      end
    end

    context 'when facing West' do
      let(:initial_bearing) { 'W' }

      it 'rotates to face South' do
        expect(subject.bearing).to eq('S')
      end
    end

    context 'when facing South' do
      let(:initial_bearing) { 'S' }

      it 'rotates to face East' do
        expect(subject.bearing).to eq('E')
      end
    end

    context 'when facing East' do
      let(:initial_bearing) { 'E' }

      it 'rotates to face North' do
        expect(subject.bearing).to eq('N')
      end
    end
  end

  describe '#rotate_right' do
    subject { Rover.new(0,0, initial_bearing) }

    before { subject.rotate_right }

    context 'when facing North' do
      let(:initial_bearing) { 'N' }

      it 'rotates to face East' do
        expect(subject.bearing).to eq('E')
      end
    end

    context 'when facing East' do
      let(:initial_bearing) { 'E' }

      it 'rotates to face South' do
        expect(subject.bearing).to eq('S')
      end
    end

    context 'when facing South' do
      let(:initial_bearing) { 'S' }

      it 'rotates to face West' do
        expect(subject.bearing).to eq('W')
      end
    end

    context 'when facing West' do
      let(:initial_bearing) { 'W' }

      it 'rotates to face North' do
        expect(subject.bearing).to eq('N')
      end
    end
  end

  describe '#move_forward' do
    let(:initial_x) { 0 }
    let(:initial_y) { 0 }

    subject { Rover.new(initial_x, initial_y, initial_bearing) }

    before { subject.move_forward }

    context 'when facing North' do
      let(:initial_bearing) { 'N' }

      it 'increments y position' do
        expect(subject.y).to eq(initial_y + 1)
      end
    end

    context 'when facing South' do
      let(:initial_bearing) { 'S' }

      it 'decrements y position' do
        expect(subject.y).to eq(initial_y - 1)
      end
    end

    context 'when facing East' do
      let(:initial_bearing) { 'E' }

      it 'increments x position' do
        expect(subject.x).to eq(initial_x + 1)
      end
    end

    context 'when facing West' do
      let(:initial_bearing) { 'W' }

      it 'decrements x position' do
        expect(subject.x).to eq(initial_x - 1)
      end
    end
  end
end
