class Validation
  class Result
    attr_reader :errors, :fields, :orphans

    def add(field, message)
      if message
        field = field.to_sym

        errors[field].add(message)
        fields.add(field)
      else
        orphans.add(field)
      end
    end

    def valid?
      !(fields.any? || orphans.any?)
    end

  private

    def initialize
      @errors  = Hash.new { |h, k| h[k] = Set[] }
      @orphans = Set[]
      @fields  = Set[]
    end
  end
end
