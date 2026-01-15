class CalculatorController < ApplicationController
  def index
    @calculators = [
      { name: 'Initial Killing & Pumping', description: 'Calculate kill weight and pumping rates', status: 'coming_soon' },
      { name: 'Pump Stuck Suspension', description: 'Suspension calculations for stuck pumps', status: 'coming_soon' },
      { name: 'Other Operation Calculations', description: 'Additional well intervention calculations', status: 'coming_soon' }
    ]
  end
end
