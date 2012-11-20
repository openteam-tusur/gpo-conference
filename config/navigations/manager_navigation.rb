# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|

  navigation.items do |primary|
    navigation.selected_class = 'current'
    primary.item :claims, 'Заявки участников', manage_conference_expert_claims_path(@conference), highlights_on: /^\/manage\/expert_claims/
  end

end
