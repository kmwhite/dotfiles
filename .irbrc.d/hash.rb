require 'ostruct'

class Hash
  def to_ostruct
    self.keys.each do |key|
      if self[key].is_a?(Hash) then
        self[key] = self[key].to_ostruct
      end
    end
    OpenStruct.new(self)
  end
end
