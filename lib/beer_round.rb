module BeerRound
  PRICES = {
    "Budvar"         => 3.00,
    "Staropramen"    => 4.00,
    "DoubleJamesons" => 5.00
  }
  
  class Calculator
    def initialize(drink_list)
      @drink_list = drink_list
    end
    
    def order
      result = header
      drink_counts.each do |drink_name, count|
        price = PRICES[drink_name]
        standard_amount = standard_cost(drink_name, count)
        discount_amount = discount(drink_name, count)
        row = [
          drink_name,
          count,
          format_price(price),
          format_price(standard_amount),
          format_price(discount_amount),
          format_price(standard_amount - discount_amount)
        ]
        result += format_row(row)
      end
      result += footer
      result.chomp
    end
    
    def total
      drink_counts.inject(0) { |total, (drink_name, count)|
        total + (standard_cost(drink_name, count) - discount(drink_name, count))
      }
    end
    
    private
    
    def standard_cost(drink_name, count)
      PRICES[drink_name] * count
    end
    
    def drink_counts
      drink_counts = @drink_list.inject(Hash.new(0)) { |counts, drink_name|
        counts[drink_name] += 1
        counts
      }
    end    
    
    def format_price(price)
      "%.02f" % price
    end
  end
  
  class CSVCalculator < Calculator
    def header
      "drink, quantity, unit_price, subtotal, discount, total\n"
    end
    
    def footer
      ""
    end
    
    def format_row(row)
      row.join(", ") + "\n"
    end
  end
  
  class XMLCalculator < Calculator
    private
    
    def header
      "<order>\n"
    end
    
    def footer
      "</order>"
    end
    
    def format_row(row)
      "  <drink name='#{row[0]}' quantity='#{row[1]}' unit_price='#{row[2]}' subtotal='#{row[3]}' discount='#{row[4]}' total='#{row[5]}' />\n"
    end
  end
  
  class CSVHappyHourCalculator < CSVCalculator    
    private
    
    def discount(drink_name, count)
      PRICES[drink_name] * count * 0.25
    end
  end

  class CSVBOGOFCalculator < CSVCalculator
    private
    
    def discount(drink_name, count)
      PRICES[drink_name] * (count / 2)
    end
  end
  
  class XMLHappyHourCalculator < XMLCalculator
    private
    
    def discount(drink_name, count)
      PRICES[drink_name] * count * 0.25
    end
  end
  
  class XMLBOGOFCalculator < XMLCalculator
    private
    
    def discount(drink_name, count)
      PRICES[drink_name] * (count / 2)
    end
  end
end