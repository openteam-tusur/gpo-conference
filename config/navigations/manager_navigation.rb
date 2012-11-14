# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|

  navigation.items do |primary|
    navigation.selected_class = 'current'
    primary.item :claims, 'Заявки', manage_expert_claims_path, highlights_on: /^\/manage\/expert_claims/
  end

end
