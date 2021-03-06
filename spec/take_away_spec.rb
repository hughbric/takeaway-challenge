require 'take_away'

describe TakeAway do
  context '#read_menu' do
    it 'exists' do
      expect(subject).to respond_to(:read_menu)
    end

    it 'returns an array of menu items' do
      expect(subject.read_menu).to be_instance_of(Array)
    end
  end

  context '#order' do
    it 'selects dish' do
      allow(subject).to receive(:menu).and_return([{ :index => 1, :item => "Miso Soup", :amount => "2.00" }])
      item_number = 1
      expect(subject.order(item_number)).to eq("You have added 1 x Miso Soup to your basket.")
    end

    it 'receives multiple quantities of a single dish' do
      expect(subject).to respond_to(:order).with(2).arguments
    end
  end

  context '#basket_summary' do
    it 'outputs the correct amount' do
      allow(subject).to receive(:menu).and_return([{ :index => 1, :item => "Miso Soup", :amount => "2.00" }])
      subject.order(1, 2)
      expect { subject.basket_summary }.to output("2 x Miso Soup = £4.00\n").to_stdout
    end
  end

  context '#total' do
    it 'calculates the correct total' do
      allow(subject).to receive(:menu).and_return([{ :index => 1, :item => "Miso Soup", :amount => "2.00" }])
      subject.order(1, 2)
      subject.basket_summary
      expect { subject.total }.to output("Total: £4.00\n").to_stdout
    end
  end

  context '#checkout' do
    subject(:takeaway) { described_class.new }

    before do
      allow(takeaway).to receive(:send_text)
    end

    it 'sends a payment confirmation text message' do
      expect(takeaway).to receive(:send_text)
      takeaway.checkout
    end
  end
end
