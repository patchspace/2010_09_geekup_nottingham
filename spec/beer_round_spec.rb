require 'spec_helper'
require_relative '../lib/beer_round'

module BeerRound
  describe CSVHappyHourCalculator do
    let(:calc) {
      CSVHappyHourCalculator.new(%w[ Budvar Budvar Staropramen Budvar DoubleJamesons DoubleJamesons ])
    }
    
    it "produces a CSV order with 25% off" do
      calc.order.should eq -%{
        drink, quantity, unit_price, subtotal, discount, total
        Budvar, 3, 3.00, 9.00, 2.25, 6.75
        Staropramen, 1, 4.00, 4.00, 1.00, 3.00
        DoubleJamesons, 2, 5.00, 10.00, 2.50, 7.50
      }
    end
    
    it "calculates the total" do
      calc.total.should eq 17.25
    end
  end

  describe XMLHappyHourCalculator do
    let(:calc) {
      XMLHappyHourCalculator.new(%w[ Budvar Budvar Staropramen Budvar DoubleJamesons DoubleJamesons ])
    }
    
    it "produces an XML order with 25% off" do
      calc.order.should eq -%{
        <order>
          <drink name='Budvar' quantity='3' unit_price='3.00' subtotal='9.00' discount='2.25' total='6.75' />
          <drink name='Staropramen' quantity='1' unit_price='4.00' subtotal='4.00' discount='1.00' total='3.00' />
          <drink name='DoubleJamesons' quantity='2' unit_price='5.00' subtotal='10.00' discount='2.50' total='7.50' />
        </order>
      }
    end
    
    it "calculates the total" do
      calc.total.should eq 17.25
    end
  end
  
  describe CSVBOGOFCalculator do
    let(:calc) {
      CSVBOGOFCalculator.new(%w[ Budvar Budvar Staropramen Budvar DoubleJamesons DoubleJamesons ])
    }
    
    it "produces a CSV order with every second drink free" do
      calc.order.should eq -%{
        drink, quantity, unit_price, subtotal, discount, total
        Budvar, 3, 3.00, 9.00, 3.00, 6.00
        Staropramen, 1, 4.00, 4.00, 0.00, 4.00
        DoubleJamesons, 2, 5.00, 10.00, 5.00, 5.00
      }
    end
    
    it "calculates the total" do
      calc.total.should eq 15.00
    end
  end
  
  describe XMLBOGOFCalculator do
    let(:calc) {
      XMLBOGOFCalculator.new(%w[ Budvar Budvar Staropramen Budvar DoubleJamesons DoubleJamesons ])
    }
    
    it "produces an XML order with every second drink free" do
      calc.order.should eq -%{
        <order>
          <drink name='Budvar' quantity='3' unit_price='3.00' subtotal='9.00' discount='3.00' total='6.00' />
          <drink name='Staropramen' quantity='1' unit_price='4.00' subtotal='4.00' discount='0.00' total='4.00' />
          <drink name='DoubleJamesons' quantity='2' unit_price='5.00' subtotal='10.00' discount='5.00' total='5.00' />
        </order>
      }
    end
    
    it "calculates the total" do
      calc.total.should eq 15.00
    end
  end
end