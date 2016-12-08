module Web
  module Admin
    class ForcedRateForm < BaseForm
      attribute :value,       Float
      attribute :currency_id, Integer
      attribute :ends_at,     DateTime

      validates :value,       presence: true
      validates :currency_id, presence: true
      validates :ends_at,     presence: true, in_future: true

      def save!
        if valid?
          @model = Rate::ForcedRate.create!(attributes)
        else
          false
        end
      end
    end
  end
end
