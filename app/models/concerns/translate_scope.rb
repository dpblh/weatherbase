module TranslateScope
  extend ActiveSupport::Concern

  included do

    scope :translate, -> { where(translate: true) }
    scope :untranslate, -> { where(translate: false) }

  end

end